/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caecae.pi3.filter;

import caecae.pi3.model.Sessao;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rogerio
 */
@WebFilter(filterName = "Filtro", urlPatterns = {"/restrito/*"})
public class Filtro implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
   
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        //verifica se esta logado
        HttpSession sessao = httpRequest.getSession();
//        
//        chain.doFilter(request, response); 
//        
//        return;
        if(sessao.getAttribute("usuario") == null){
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login/validate");
            return;
        }

        Sessao usuario = (Sessao) sessao.getAttribute("usuario");
        
        if(verificaAcesso(usuario, httpRequest)){
           chain.doFilter(request, response); 
        } else{
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login/validate");
        }
    }

    @Override
    public void destroy() {        
    }

    @Override
    public void init(FilterConfig filterConfig) {        
       
    }

    private boolean verificaAcesso(Sessao usuario, HttpServletRequest request){
        String urlAcessada = request.getRequestURI();
        
//        throw new RuntimeException(usuario.getCargo());
        if(usuario.getCargo() == null){
            throw new RuntimeException("SEM USER");
        }
        if(usuario.getCargo().equalsIgnoreCase("DEV")){
            return true;
        }
        if(urlAcessada.contains("/vendas")){
            return usuario.getCargo().equalsIgnoreCase("Vendedor");
        }
        if(urlAcessada.contains("/produtos")){
            return usuario.getCargo().equalsIgnoreCase("BackOffice");
        }
        if(urlAcessada.contains("/cliente")){
            return usuario.getCargo().equalsIgnoreCase("Vendedor") 
                    || usuario.getCargo().equalsIgnoreCase("Gerente");
        }
        if(urlAcessada.contains("/funcionarios")){
            return usuario.getCargo().equalsIgnoreCase("Gerente");
        }
        
        return false;
    }
   
}
