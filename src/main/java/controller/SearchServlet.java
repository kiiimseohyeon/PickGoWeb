//태그 기반 검색 처리
package controller;

import dao.PlaceDAO;
import dto.Place;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tag = request.getParameter("tag");  // ex: /search?tag=가족여행
        PlaceDAO dao = new PlaceDAO();
        List<Place> list = dao.getPlacesByTag(tag);

        request.setAttribute("placeList", list);
        RequestDispatcher rd = request.getRequestDispatcher("searchResult.jsp");
        rd.forward(request, response);
    }
}
