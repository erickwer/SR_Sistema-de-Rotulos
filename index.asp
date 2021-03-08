<%
    session("idUsu") = request("idUsu")
%>
<!--#include file="base.asp"-->

<div class="col">
    <div class="col-lg-10">
        <div class="card shadow mb-4 text-center">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Olá, <%=session("nomeFunc")%></h6>
            </div>
            <div class="card-body text-center">
                <p>Seja bem-vindo(a) ao Sistema de Rotulagem. Aqui você pode realizar o cadastro de empresas, produtos.</p>
                <p>Utilize o menu lateral para acessar as funcionalidades do sistema.</p>
            </div>
        </div>
    </div>
</div>
