package basai.favourite.controller;

import basai.favourite.model.dao.FavouriteDAO;
import basai.favourite.model.dto.FavouriteDTO;
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

@WebServlet("/renter/wishlist")
public class GetFavouriteServlet extends HttpServlet {

    private final FavouriteDAO favouriteDAO = new FavouriteDAO();
    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        User user = (User) request.getSession().getAttribute("user");
        int renterId = user.getUser_id();

        ArrayList<FavouriteDTO> favourites = favouriteDAO.getFavouritesByRenter(renterId);

        // Fetch full room details for each favourite
        ArrayList<RoomDTO> wishlistedRooms = new ArrayList<>();
        for (FavouriteDTO fav : favourites) {
            RoomDTO room = roomDAO.getRoomById(fav.getRoomId());
            if (room != null) wishlistedRooms.add(room);
        }

        request.setAttribute("wishlistedRooms", wishlistedRooms);
        request.setAttribute("favouriteCount", wishlistedRooms.size());
        request.getRequestDispatcher("/views/renter/wishlist.jsp").forward(request, response);
    }
}