<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file ="lib/conexao.asp"-->
<!--#include file="base.asp"-->
<%
  sql = "SELECT P.Id as IdProduto, IdEmpresa, Descricao, EnderecoImagem, ConteudoLiquido, NomeFantasia, NumeroRegistro  FROM SR_Produto as P  INNER JOIN SR_Empresa as E ON P.IdEmpresa = E.Id WHERE P.Status=1"
  Set ObjRst = conn.Execute(sql)
%>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Rótulo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body ">
        <img id="imageModal" src="" class="img-fluid zoom" alt="...">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<script type="text/javascript">
  $(document).ready(function(){

  $('.modal-trigger').on("click", function(e) {
    e.preventDefault();

    var $this  = $(this),
        $modal = $($this.data("target")),
        linkImg = $this.data("value")

      $modal.find('#exampleModal').html(name);
      document.getElementById("imageModal").src = linkImg;
        $modal.modal('show');
    });
 });

var url_string = window.location.href;
var url = new URL(url_string);
var resp = url.searchParams.get("resp");

mensagem(resp)

function mensagem(resp) {
  if (resp == "ok"){
     Swal.fire({
      title: "Ótimo!!!",
      text: "Produto desabilitado com sucesso!\n ",
      icon: "success",
      button: "Ok!",
      });
    return false;
  }
  else if (resp == "err"){
  Swal.fire({
      title: "Ops!!!",
      text: "Ocorreu um erro ao desabilitar o produto!",
      icon: "error",
      button: "Ok!",
      });
    return false;
  }
  else{
    return false;
  }
}

function desativarProduto(prodId){  
  Swal.fire({
  title: 'Deseja continuar?',
    text: "O produto será desativado e não será mais listado no sistema!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',    
    cancelButtonText: 'Cancelar',
    confirmButtonText: 'Sim, prosseguir!'
  }).then((result) => {
    if (result.value) {
        window.location="crud_produto.asp?id="+prodId+"&operacao=2"
    }
  })
}
</script>

<div class="col-lg-12">
  <div class="card mb-4 ">
    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
      <h6 class="m-0 font-weight-bold text-primary"> Lista Geral de Produtos </h6>
    </div>
    <div class="table-responsive p-3">
      <table class="table align-items-center table-flush table-sm" id="dataTable" >
        <thead class="thead-light">
          <tr>
            <th>Descrição do Produto</th>
            <th>Nome Empresa</th>
            <th>Registro</th>
            <th>Conteudo Liquido</th>
            <th>Rótulo</th>
            <th>Opções</th>
          </tr>
        </thead>
        <tbody>
      <%
	   		Do while not ObjRst.EOF 
				cont =cont+1
	    %>
        <tr>
            <td ><%=ObjRst("Descricao")%></td>
            <td ><%=ObjRst("NomeFantasia")%></td>
            <td ><%=ObjRst("NumeroRegistro")%></td>  
            <td ><%=ObjRst("ConteudoLiquido")%></td>
            <td >
              <button type="button" class="btn modal-trigger" data-bs-toggle="modal" data-bs-target="#exampleModal"  data-value="<%=ObjRst("EnderecoImagem")%>" style=" width: 7rem; height: 4rem;">
                <img src="<%=ObjRst("EnderecoImagem")%>" style=" width: 6rem; height: 3rem; border: 1px #555; border-radius: 6px;">
              </button>
            </td>       
            <td>
              <a class="btn btn-danger btn-sm" onClick="desativarProduto('<%=ObjRst("IdProduto")%>')" alt="">
                <i class="fas fa-trash"></i>
              </a>
            </td>
        </tr>
      <% 
				ObjRst.Movenext()
				loop 
				set ObjRst =  Nothing 
			%>
      </tbody>
      </table>
    </div>
  </div>
</div>
<script src="vendor/datatables/jquery.dataTables.min.js"></script>
<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css"></script>

  <!-- Page level custom scripts -->
  <script>
    $(document).ready(function () {
       $('#dataTable').DataTable( {
        "language": {
            "lengthMenu": "Exibindo _MENU_ registros por página",
            "zeroRecords": "Nenhum dado encontrado",
            "info": "Página _PAGE_ de _PAGES_",
            "infoEmpty": "Nenhum registro encontrado",
            "infoFiltered": "(_MAX_ rotas filtradas)",
            "search": "Buscar:",
            "paginate":{
              "previous": "Anterior",
              "next": "Próximo"
            }
        }
    } );
    });
  </script>
