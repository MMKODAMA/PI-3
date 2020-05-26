<%-- 
    Document   : produtos
    Created on : 15/04/2020, 17:46:03
    Author     : Luciana Alves
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Produtos</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/produtoEstilo.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body id="duas-col">
        <header>
            <nav>
                <div class="center">
                    <ul>
                        <button type="button" value="Voltar" onClick="history.go(-1)">Voltar</button>
                        <li><a href="/clientes">Gestao de Cliente</a></li>
                        <li><a href="/produtos">Gestao de Produtos</a></li>
                        <li><a href="/relatorioAnalitico.jsp">Relatorio Financeiro</a></li>
                        <li><a href="/vendas.jsp">Vendas</a></li>
                    </ul>
                </div><!--center-->
            </nav>
        </header>
        <div id="espacador">
            <br>
        </div><!--espacador-->
        <section class="center">
            <div class="nome-aba">Cadastro de Produtos</div>
            <div class="container">
                <div class="form-container">
                    <form action="${pageContext.request.contextPath}/produtos/salvar" method="POST">
                        <div>
                            <label for="">Nome: </label>
                            <input type="text" name="nome">

                        </div>
                        <div>
                            <label for="">Valor: </label>
                            <input type="text" name="valor">                         
                        </div>     
                        <div>
                            <label for="">Quantidade: </label>
                            <input type="text" name="quantidade">
                        </div>     
                        <div>
                            <label for="">Descrição: </label>
                            <input type="text" name="descricao">
                        </div> 

                        <div class="b">
                            <button type="submit" name="salvarBtt">Salvar Produto</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="conteudo">

                <form action="${pageContext.request.contextPath}/produtos" method="GET">
                    <label>Nome Produto:</label>
                    <input name="produtoNome" type="text"/>                        
                    <button type="submit">Buscar</button>
                </form>

            </div><!--conteudo-->

            <div class="pesquisar">
                <table>
                    <tr>
                        <th class="nomeProduto">Nome</th>
                        <th class="valor">Valor</th>
                        <th class="estoque">Estoque</th>
                        <th class="descricao">Descrição</th>
                        <th class="excluirB">Excluir</th>
                        <th class="atualizarB">Atualizar</th>
                    </tr>
                    <c:forEach items="${listaProdutos}" var="produto" >
                        <tr class="hover">
                            <td class="nome" ><c:out value="${produto.getNome()}"/></td>
                            <td class="valor"><c:out value="${produto.getValor()}"/></td>
                            <td class="estoque"><c:out value="${produto.getQuantidade()}"/></td>                           
                            <td class="descricao"><c:out value="${produto.getDescricao()}"/></td>

                            <td class="buttonExcluir">
                                <form action="${pageContext.request.contextPath}/produtos/excluir" method="GET">
                                    <input name="produtoId" value="${produto.getId()}" type="hidden"/>                        
                                    <button type="submit">Excluir</button>
                                </form>
                            </td>
                            <td class="buttonAtualizar">
                                <form action="${pageContext.request.contextPath}/produtos/redireciona-para-atualizar" method="GET">
                                    <input name="produtoId" value="${produto.getId()}" type="hidden"/>                        
                                    <button type="/telaAtualizar">Atualizar</button>

                                </form>
                            </td>

                        </tr>
                    </c:forEach>
                </table>
            </div><!--pesquisar-->


            <div style="clear: both;"></div>
        </section><!--center-->
    </body>
</html>
