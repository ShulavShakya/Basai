package basai.room.controller;

import basai.room.model.dto.RoomDTO;
import basai.room.model.dao.RoomDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/rooms/detail")
public class GetRoomByIdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam == null || roomIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }

        int roomId;
        try {
            roomId = Integer.parseInt(roomIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }
        RoomDAO roomDAO = new RoomDAO();

        RoomDTO room = roomDAO.getRoomById(roomId);

        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/rooms/browse");
            return;
        }

        request.setAttribute("room", room);
        request.getRequestDispatcher( "/views/renter/roomDetail.jsp")
                .forward(request, response);
    }
}