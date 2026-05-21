package basai.favourite.model.dao;

import basai.favourite.model.Favourite;
import basai.favourite.model.dto.FavouriteDTO;

import java.util.ArrayList;
import java.util.List;

public interface FavouriteInterface {
    void addFavourite(Favourite favourite);
    FavouriteDTO getFavouriteById(int favouriteId);
    ArrayList<FavouriteDTO> getFavouritesByRenter(int renterId);
    boolean isFavourite(int renterId, int roomId);
    void deleteFavouriteByRenterAndRoom(int renterId, int roomId);
    List<Integer> getFavouriteRoomIds(int renterId);
}
