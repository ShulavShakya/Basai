package basai.favourite.controller;

import basai.favourite.model.Favourite;
import basai.favourite.model.dao.FavouriteDAO;

import basai.user.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/favourites/toggle")
public class ToggleFavouriteServlet extends HttpServlet {

    private final FavouriteDAO favouriteDAO = new FavouriteDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        int renterId = user.getUser_id();

        int roomId = Integer.parseInt(request.getParameter("roomId"));

        if (favouriteDAO.isFavourite(renterId, roomId)) {
            favouriteDAO.deleteFavouriteByRenterAndRoom(renterId, roomId);
        } else {
            favouriteDAO.addFavourite(new Favourite(0, renterId, roomId, null));
        }

        response.sendRedirect(request.getHeader("Referer"));
    }
}
