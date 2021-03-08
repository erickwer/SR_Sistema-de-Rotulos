<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file="base.asp"-->
<!--#include file="lib/conexao.asp"-->
<%
  sql =  "SELECT * FROM SR_Empresa WHERE Id="&request("Id")&""
  Set rs = conn.Execute(sql)
%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
var url_string = window.location.href;
var url = new URL(url_string);
var resp = url.searchParams.get("resp");
var idUsu = url.searchParams.get("idUsu");
mensagem(resp)

function mensagem(resp) {
  if (resp == "ins"){
     Swal.fire({
      title: "Ótimo!!!",
      text: "Produto cadastrado com sucesso!\n Para visualizar a lista acesse o menu de produtos e clique em 'Lista de Produtos'. ",
      icon: "success",
      button: "Ok!",
      });
      return false;
  }
  else
  return false;
}

</script>
<% 
%>
<div class="col-lg-10">
    <div class="card mb-6">
      <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
        <h6 class="m-0 font-weight-bold text-primary">Cadastrar Produto da Empresa - <%=rs("NomeFantasia")%> </h6>
      </div>
      <div class="card-body">
        <form name="form_produto" enctype="multipart/form-data" method="POST" action="crud_produto.asp" >
          <div class="form-group">
          <input type="text" class="form-control col-form-sm" name="IdEmpresa" id="IdEmpresa" value="<%=request("Id")%>" hidden>
        </div>
        <div class="form-group">
          <label for="Descricao" class="col-form-label col-form-label-sm" >Descrição do produto</label>
          <input type="text" class="form-control col-form-sm" name="Descricao" id="Descricao" required>
        </div>
        <div class="form-group row g-3">
          <div class="col-4">
            <label for="Registro" class="col-form-label col-form-label-sm" >Nº Registro</label>
            <input type="text" class="form-control col-form-sm" name="Registro" id="Registro" required>
          </div>
          <div class="col-3">
            <label for="Conteudo" class="col-form-label col-form-label-sm" >Conteúdo Liquido</label>
            <input type="text" class="form-control col-form-sm mb-3" name="Conteudo" id="Conteudo" required>
          </div>
          </div>
        <div class="form-group">
          <input type="file" accept="image/png, image/jpeg" name="Imagem" id="Imagem" required>
        </div>
        <button class="btn btn-primary btn-icon-split">
          <span class="icon text-white-50">
            <i class="fas fa-arrow-right"></i>
          </span>
          <span class="text">Cadastrar</span>
        </button>
        </form>
      </div>
    </div>
  </div>