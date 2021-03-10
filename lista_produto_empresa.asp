<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file ="lib/conexao.asp"-->
<!--#include file="base.asp"-->
<%
  sql = "SELECT * FROM SR_Produto WHERE IdEmpresa = "&request("id")&" AND Status=1"
  Set ObjRst = conn.Execute(sql)

  sql2 = "SELECT * FROM SR_Empresa WHERE Id="&request("id")&""
  Set rs = conn.Execute(sql2)

%>
<style type="text/css">
.img-container{
   overflow: hidden;
}

.img-container img{
   width: 100%;
   height: 100%;
   -webkit-transition: -webkit-transform .5s ease;
   transition: transform .5s ease;
}

.img-container:hover img{
   -webkit-transform: scale(1.8);
   transform: scale(1.8);
}

</style>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Rótulo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body d-flex align-items-center img-container">
        <img id="imageModal" src="" class="img-fluid mx-auto d-block north" alt="..." style="height: 400px; width:400px" >
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
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
      <h6 class="m-0 font-weight-bold text-primary"> Lista de Produtos - <%=rs("NomeFantasia")%>  </h6>
    </div>
    <div class="table-responsive p-3">
      <table class="table align-items-center table-flush table-sm" id="dataTable" >
        <thead class="thead-light">
          <tr>
            <th>Descrição</th>
            <th>Registro</th>
            <th>Conteudo Liquido</th>
            <th>Imagem</th>
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
            <td ><%=ObjRst("NumeroRegistro")%></td>  
            <td ><%=ObjRst("ConteudoLiquido")%></td>
            <td >
              <button type="button" class="btn modal-trigger" data-bs-toggle="modal" data-bs-target="#exampleModal"  data-value="<%=ObjRst("EnderecoImagem")%>" style=" width: 7rem; height: 4rem;">
                <img src="<%=ObjRst("EnderecoImagem")%>" style=" width: 6rem; height: 3rem; border: 1px #555; border-radius: 6px;">
              </button>
            </td>       
            <td>
              <a class="btn btn-danger btn-sm" onClick="desativarProduto('<%=ObjRst("Id")%>')" alt="">
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
