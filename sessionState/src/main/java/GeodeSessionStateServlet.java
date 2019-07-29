import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "GeodeSessionStateServlet", urlPatterns = {"/index"})
public class GeodeSessionStateServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    if (session.isNew()) {
      request.setAttribute("isNew", "Session is new.");
    } else {
      request.setAttribute("isNew", "Session already existing");
      session.setMaxInactiveInterval(90);
    }

    if (request.getParameter("action") != null) {
      if (request.getParameter("action").equals("Set Attribute") && request.getParameter("key") != null
          && !request.getParameter("value").equals("null")) {
        session.setAttribute(request.getParameter("key"), request.getParameter("value"));
      }

      if (request.getParameter("action").equals("Get Attribute") && request.getParameter("key") != null) {
        request.setAttribute("getKey", session.getAttribute(request.getParameter("key")));
      }

      if (request.getParameter("action").equals("Delete Attribute") && request.getParameter("key") != null) {
        session.removeAttribute(request.getParameter("key"));
      }
    }

    request.getRequestDispatcher("/index.jsp").forward(request, response);
  }
}
