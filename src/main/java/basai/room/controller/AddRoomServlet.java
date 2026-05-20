package basai.room.controller;

import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import basai.user.model.User;
import basai.utils.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;

@WebServlet("/rooms/add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,   // 2 MB
        maxFileSize       = 10 * 1024 * 1024,  // 10 MB per file
        maxRequestSize    = 30 * 1024 * 1024   // 30 MB total
)
public class AddRoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void service (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Get form data
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String city = request.getParameter("city");
            String address = request.getParameter("address");
            String rentPriceStr = request.getParameter("rentPrice");
            String furnishingStr = request.getParameter("furnishingStatus");
            String roomTypeStr = request.getParameter("roomType");

            BigDecimal rentPrice = new BigDecimal(rentPriceStr != null && !rentPriceStr.trim().isEmpty() ? rentPriceStr : "0");

            // Convert to Enum safely
            RoomDTO.FurnishingStatus furnishingStatus = RoomDTO.FurnishingStatus.Unfurnished; // default
            if (furnishingStr != null && !furnishingStr.isEmpty()) {
                try {
                    furnishingStatus = RoomDTO.FurnishingStatus.valueOf(furnishingStr);
                } catch (Exception ignored) {}
            }

            RoomDTO.RoomType roomType = RoomDTO.RoomType.SINGLE; // default
            if (roomTypeStr != null && !roomTypeStr.isEmpty()) {
                try {
                    roomType = RoomDTO.RoomType.valueOf(roomTypeStr.toUpperCase());
                } catch (Exception ignored) {}
            }

            // Facilities
            String[] facilitiesArray = request.getParameterValues("facilities");
            String facilities = facilitiesArray != null ? String.join(",", facilitiesArray) : "";

            // === Save Multiple Photos ===
            ArrayList<String> savedPhotos = Helper.saveMultipleFiles(request, "photos", "roomPhotos");

            String photo1 = savedPhotos.size() > 0 ? savedPhotos.get(0) : null;
            String photo2 = savedPhotos.size() > 1 ? savedPhotos.get(1) : null;
            String photo3 = savedPhotos.size() > 2 ? savedPhotos.get(2) : null;

            // Create RoomDTO
            RoomDTO roomDTO = new RoomDTO(
                    0,
                    user.getUser_id(),
                    user.getName(),
                    title,
                    description,
                    rentPrice,
                    photo1,
                    photo2,
                    photo3,
                    null,
                    null,
                    city,
                    address,
                    roomType,
                    furnishingStatus,
                    RoomDTO.AvailabilityStatus.Available,
                    facilities,
                    LocalDateTime.now(),
                    LocalDateTime.now()
            );

            boolean added = roomDAO.addRoom(roomDTO);

            if (added) {
                response.sendRedirect(request.getContextPath() + "/rooms/my-listings?success=Room added successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/owner/addListing.jsp?error=Failed to add room");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/owner/addListing.jsp?error=An error occurred");
        }
    }
}