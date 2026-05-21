package basai.room.model.dao;

import basai.room.model.dto.RoomDTO;

import java.util.ArrayList;

public interface RoomInterface {
    boolean addRoom(RoomDTO roomdto);
    ArrayList<RoomDTO> getAllRooms();
    ArrayList<RoomDTO> getAllUserRooms();
    RoomDTO getRoomById(int roomId);
    boolean updateRoom(RoomDTO room);
    boolean deleteRoom(int roomId);
    ArrayList<RoomDTO> getRoomsByOwner(int ownerId);
    ArrayList<RoomDTO> filterRooms(String keyword, String city, String furnishing, String roomType, String[] facilities, String sort);
}
