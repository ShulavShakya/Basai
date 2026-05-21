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
import java.util.List;

@WebServlet("/rooms/browse")
public class GetAllUsersRoomsServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        RoomDAO roomDAO = new RoomDAO();
        FavouriteDAO favouriteDAO = new FavouriteDAO();

        String keyword    = request.getParameter("keyword");
        String city       = request.getParameter("city");
        String furnishing = request.getParameter("furnishing");
        String roomType = request.getParameter("roomType");
        String[] facilities = request.getParameterValues("facilities");
        String sort       = request.getParameter("sort");

        ArrayList<RoomDTO> rooms = roomDAO.filterRooms(keyword, city, furnishing, roomType, facilities, sort);
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            List<Integer> favIds = favouriteDAO.getFavouriteRoomIds(user.getUser_id());
            String favouriteRoomIds = "," + favIds.toString().replaceAll("[\\[\\] ]", "") + ",";
            request.setAttribute("favouriteRoomIds", favouriteRoomIds);
        }

        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/views/renter/browseRooms.jsp").forward(request, response);
    }
}
