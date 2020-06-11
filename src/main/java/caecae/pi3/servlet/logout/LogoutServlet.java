/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caecae.pi3.servlet.logout;

import caecae.pi3.model.Sessao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");
        
        Sessao s = new Sessao();
        s.setCargo(null);
        s.setFilial(-1);
        s.setUser(null);
       
        response.sendRedirect(request.getContextPath() + "/login/validate");
    }
}
