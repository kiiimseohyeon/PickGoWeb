//지역 기반 추천 처리
package controller;

import dao.PlaceDAO;
import dto.Place;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/region")
public class RegionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String region = request.getParameter("name"); // ex: /region?name=서울
        PlaceDAO dao = new PlaceDAO();
        List<Place> list = dao.getPlacesByRegion(region);

        request.setAttribute("placeList", list);
        RequestDispatcher rd = request.getRequestDispatcher("regionResult.jsp");
        rd.forward(request, response);
    }
}
