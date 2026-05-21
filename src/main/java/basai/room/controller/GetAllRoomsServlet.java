package basai.room.controller;

import basai.room.model.dao.RoomDAO;
import basai.room.model.dto.RoomDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/rooms/all")
public class GetAllRoomsServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        RoomDAO room = new RoomDAO();
        ArrayList<RoomDTO> rooms = room.getAllRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/views/admin/listings.jsp").forward(request, response);
    }
}
