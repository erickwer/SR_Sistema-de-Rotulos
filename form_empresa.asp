<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file="base.asp"-->
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
      text: "Empresa cadastrada com sucesso!\n Para visualizar a lista acesse o menu de empresas e clique em 'Lista de Empresas'. ",
      icon: "success",
      button: "Ok!",
      });
      return false;
  }
  else
  return false;
}


</script>

<div class="col-lg-11">
  <!-- Select2 -->
  <div class="card mb-6">
    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
      <h6 class="m-0 font-weight-bold text-primary">Cadastrar Empresa</h6>
    </div>
    <div class="card-body">
      <form name="formempresa" id="formempresa" action="crud_empresa.asp" method="POST">              
      <div class="form-group">
        <label for="NomeEmpresa" class="col-form-label col-form-label-sm" >Nome empresa</label>
        <input type="text" class="form-control col-form-sm" name="NomeEmpresa" id="NomeEmpresa" required>
      </div>
      <div class="form-group">
        <label for="NomeFantasia" class="col-form-label col-form-label-sm" >Nome fantasia</label>
        <input type="text" class="form-control col-form-sm" name="NomeFantasia" id="NomeFantasia" required>
      </div>
      <div class="form-group row g-3">
        <div class="col">
          <label for="CNPJ" class="col-form-label col-form-label-sm" >CNPJ</label>
          <input type="text" class="form-control col-form-sm" name="Cnpj" onkeypress="$(this).mask('00.000.000/0000-00')"  required>
        </div>
        <div class="col">
          <label for="Telefone" class="col-form-label col-form-label-sm" >Telefone</label>
          <input type="text" class="form-control col-form-sm" name="Telefone" id="Telefone" onkeypress="$(this).mask('(00)00000-0000')" required>
        </div>
      </div>
      <div class="form-group row g-3">
        <div class="col">
        <label for="Email" class="col-form-label col-form-label-sm" >Email</label>
        <input type="text" class="form-control  col-form-sm" name="Email" id="Email" required>
        </div>
        <div class="col">
        <label for="Tipo" class="col-form-label col-form-label-sm" >Tipo</label>
        <select class="select2-single form-control col-form-label-sm" name="Tipo" id="Tipo" required> 
          <option value="" selected>Tipo</option>
          <option value="Abatedouro Frigorífico cárneos">Abatedouro Frigorífico cárneos</option>
          <option value="Abatedouro de pescados">Abatedouro de pescados</option>
          <option value="Abatedouro de Aves">Abatedouro de Aves</option>
          <option value="Unidade de beneficiamento de Leite e derivados">Unidade de beneficiamento de Leite e derivados</option>
          <option value="Unidade de beneficiamento de produtos de abelha">Unidade de beneficiamento de produtos de abelha</option>
          <option value="Entreposto de produtos de origem animal">Entreposto de produtos de origem animal</option>
        </select>
        </div>
      </div>
  <div class="form-group">
    <div class="row mb-3">
      <div class="col-sm-10 offset-sm">
        <div class="form-check">
          <input class="form-check-input" value="1" type="checkbox" name="SISBI" id="SISBI"  >
          <label class="form-check-label" for="SISBI">
            Possui SISBI
          </label>
        </div>
      </div>
    </div>
      </div>
      <input type="text" class="form-control" id="operacao" name="operacao" value="1" hidden>
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