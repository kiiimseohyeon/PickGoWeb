//장소 상세 정보 조회
package controller;

import dao.PlaceDAO;
import dto.Place;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/detail")
public class PlaceDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        PlaceDAO dao = new PlaceDAO();
        Place place = dao.getPlaceById(id); // 이 메서드는 PlaceDAO에 추가 구현 필요

        request.setAttribute("place", place);
        RequestDispatcher rd = request.getRequestDispatcher("placeDetail.jsp");
        rd.forward(request, response);
    }
}
