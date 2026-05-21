package basai.room.controller;

import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;

@WebServlet("/rooms/add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize       = 10  * 1024 * 1024,
        maxRequestSize    = 30  * 1024 * 1024
)
public class AddRoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        request.getRequestDispatcher("/views/owner/addListing.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {

        Integer ownerId  = (Integer) request.getSession().getAttribute("userId");
        String ownerName = (String)  request.getSession().getAttribute("fullName");
        if (ownerId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String title        = request.getParameter("title");
            String description  = request.getParameter("description");
            String city         = request.getParameter("city");
            String address      = request.getParameter("address");
            String rentPriceStr = request.getParameter("rentPrice");
            String furnishingStr= request.getParameter("furnishingStatus");
            String roomTypeStr  = request.getParameter("roomType");

            BigDecimal rentPrice = new BigDecimal(
                    rentPriceStr != null && !rentPriceStr.isBlank() ? rentPriceStr : "0");

            RoomDTO.FurnishingStatus furnishingStatus = RoomDTO.FurnishingStatus.Unfurnished;
            try { furnishingStatus = RoomDTO.FurnishingStatus.valueOf(furnishingStr); }
            catch (Exception ignored) {}

            RoomDTO.RoomType roomType = RoomDTO.RoomType.SINGLE;
            try { roomType = RoomDTO.RoomType.valueOf(roomTypeStr.toUpperCase()); }
            catch (Exception ignored) {}

            String[] facilitiesArray = request.getParameterValues("facilities");
            String facilities = facilitiesArray != null
                    ? String.join(",", facilitiesArray) : "";

            String uploadDir = request.getServletContext().getRealPath("/uploads/rooms/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            ArrayList<String> photoPaths = new ArrayList<>();

            Collection<Part> parts = request.getParts();
            int index = 0;

            for (Part part : parts) {
                if (!part.getName().equals("photos") || part.getSize() == 0) continue;
                if (index >= 3) break; // max 3 photos

                String originalName = null;
                String header = part.getHeader("content-disposition");
                for (String token : header.split(";")) {
                    token = token.trim();
                    if (token.startsWith("filename")) {
                        originalName = token.substring(token.indexOf('=') + 1)
                                .trim().replace("\"", "");
                        originalName = new File(originalName).getName();
                        break;
                    }
                }

                if (originalName == null || originalName.isBlank()) continue;

                String savedName = System.currentTimeMillis() + "_" + index + "_" + originalName;
                File   destFile  = new File(dir, savedName);


                try (InputStream  in  = part.getInputStream();
                     OutputStream out = new FileOutputStream(destFile)) {
                    byte[] buffer = new byte[8192];
                    int    read;
                    while ((read = in.read(buffer)) != -1) {
                        out.write(buffer, 0, read);
                    }
                }

                photoPaths.add("uploads/rooms/" + savedName);
                System.out.println("Saved photo: " + destFile.getAbsolutePath());
                index++;
            }

            String photo1 = photoPaths.size() > 0 ? photoPaths.get(0) : null;
            String photo2 = photoPaths.size() > 1 ? photoPaths.get(1) : null;
            String photo3 = photoPaths.size() > 2 ? photoPaths.get(2) : null;

            RoomDTO roomDTO = new RoomDTO(
                    0, ownerId, ownerName,
                    title, description, rentPrice,
                    photo1, photo2, photo3, null, null,
                    city != null ? city.trim() : "",
                    address != null ? address.trim() : "",
                    roomType, furnishingStatus,
                    RoomDTO.AvailabilityStatus.Available,
                    facilities, null, null
            );

            boolean added = roomDAO.addRoom(roomDTO);

            if (added) {
                response.sendRedirect(request.getContextPath()
                        + "/rooms/my-listings?success=Room added successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to add room. Please try again.");
                request.getRequestDispatcher("/views/owner/addListing.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/views/owner/addListing.jsp")
                    .forward(request, response);
        }
    }
}