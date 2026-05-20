package basai.room.model.dao;

import basai.room.model.dto.RoomDTO;
import basai.room.model.Room;

import java.util.ArrayList;

public interface RoomInterface {
    boolean addRoom(RoomDTO roomdto);
    ArrayList<RoomDTO> getAllRooms();
    RoomDTO getRoomById(int roomId);
    boolean updateRoom(Room room);
}
