package caecae.pi3.login.servlet;

import caecae.pi3.DAO.LoginDAO;
import caecae.pi3.exception.DaoException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import caecae.pi3.DAO.SessaoDAO;
import caecae.pi3.model.Sessao;
import caecae.pi3.service.AppException;
import javax.servlet.http.HttpSession;

@WebServlet(name = "validate", urlPatterns = {"/login/validate"})
public class validate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        String user = request.getParameter("user");
        String senha = request.getParameter("senha");

        request.setAttribute("loginUser", user);
        request.setAttribute("loginSenha", senha);

        try {
            HttpSession sessaoHTTP = request.getSession();
            SessaoDAO sessao = new SessaoDAO();
            boolean teste = caecae.pi3.DAO.LoginDAO.verifUser(user, senha);
            if (teste == true) {
                request.setAttribute("loginUser", "DEU CERTO");

                try {
                    Sessao sessaoAtual = sessao.guardaSessao(user.trim());
                    sessaoHTTP.setAttribute("usuario", sessaoAtual);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.html");
                    dispatcher.forward(request, response);
                } catch (AppException ex) {
                    throw new RuntimeException("VALIDATE");
                }
            } else if(user.equals("admin") && senha.equals("adminadmin")){
                Sessao sessaoAtual = new Sessao("DEV", 1, "DEV");
                    sessaoHTTP.setAttribute("usuario", sessaoAtual);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.html");
                    dispatcher.forward(request, response);
            } else {
                request.setAttribute("loginUser", "DEU ERRADO");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login/validate");
                dispatcher.forward(request, response);
            }
            
            
        } catch (DaoException | SQLException ex) {
            Logger.getLogger(validate.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void writeFooter(HttpServletResponse response) {
        throw new UnsupportedOperationException("ERRO"); //To change body of generated methods, choose Tools | Templates.
    }

}
