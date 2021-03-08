<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file="base.asp"-->
<%
    sql = "SELECT * FROM SR_Empresa WHERE Status=1"
    Set rs = conn.Execute(sql)
%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<script>

    function desativarEmpresa(empresaId){  
      Swal.fire({
      title: 'Deseja continuar?',
        text: "A empresa e todos os seus produtos serão desativados!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',    
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Sim, prosseguir!'
      }).then((result) => {
        if (result.value) {
            window.location="crud_empresa.asp?id="+empresaId+"&operacao=2"
        }
      })
    }
    
</script>

<div class="col-lg-12">
    <!-- Select2 -->
    <div class="card mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">Empresas Cadastradas</h6>
        </div>
         <div class="table-responsive p-3">
        <table class="table align-items-center table-flush table-sm" id="dataTable" >
        <thead class="thead-light">
            <tr>
            <th >Nome Fantasia</th>
            <th >CNPJ</th>
            <th >Tipo</th>
            <th >Opções</th>
            </tr>
        </thead>
        <tbody>
            <%
	   		Do while not rs.EOF 
				cont =cont+1
	        %>
            <tr>
                <td><%=rs("NomeFantasia")%></td>
                <td><%=rs("CNPJ")%></td>
                <td><%=rs("Tipo")%></td>                
                <td>
                    <a href="lista_produto_empresa.asp?id=<%=rs("Id")%>&operacao=2" class="btn btn-warning btn-sm" alt="Visualizar produtos">
                        <i class="fas fa-eye"></i>
                    </a>
                    <a href="form_produto.asp?id=<%=rs("Id")%>" class="btn btn-primary btn-sm" alt="">
                        <i class="fas fa-plus-circle"></i>
                    </a>
                    <a class="btn btn-danger btn-sm" onClick="desativarEmpresa('<%=rs("Id")%>')" alt="">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
            <% 
                rs.Movenext()
                loop 
                set rs =  Nothing 
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