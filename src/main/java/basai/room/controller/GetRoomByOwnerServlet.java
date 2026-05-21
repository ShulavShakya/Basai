package basai.room.controller;

import basai.room.model.Room;
import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/rooms/my-listings")   // ← Better URL pattern
public class GetRoomByOwnerServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            ArrayList<RoomDTO> rooms = roomDAO.getRoomsByOwner(user.getUser_id());

            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("/views/owner/myListings.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load your listings");
            request.getRequestDispatcher("/views/owner/myListings.jsp")
                    .forward(request, response);
        }
    }
}