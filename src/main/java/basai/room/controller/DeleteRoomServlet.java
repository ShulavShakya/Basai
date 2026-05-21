package basai.room.controller;

import basai.room.model.dao.RoomDAO;
import basai.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/room/delete")
public class DeleteRoomServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("roomId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("views/login.jsp");
        }

        RoomDAO roomDAO = new RoomDAO();
        boolean result = roomDAO.deleteRoom(id);

    if (result){
        session.setAttribute("success", "Room deleted successfully.");
    }
    else{
        session.setAttribute("error", "Room deletion failed.");
    }
    response.sendRedirect("viewRooms");
    }

}
