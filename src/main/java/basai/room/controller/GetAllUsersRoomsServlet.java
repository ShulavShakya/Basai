package basai.room.controller;

import basai.favourite.model.dao.FavouriteDAO;
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

@WebServlet("/rooms/browse")
public class GetAllUsersRoomsServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        RoomDAO roomDAO = new RoomDAO();

        ArrayList<RoomDTO> rooms = roomDAO.getAllUserRooms();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/views/renter/browseRooms.jsp").forward(request, response);
    }
}
