  <%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
  <!--#include file ="lib/conexao.asp"-->
  <% 	

    if request.form("SISBI") = "" then
        sisbi = 0
    elseIf request.form("SISBI") = 1 then
        sisbi = 1
    end if
	op = request("operacao")
	status = 1
	
    if session("idUsu") = null or session("idUsu") = " " then
		%>
		<script>
            alert('Não foi possivel cadastrar. Parâmetros inválidos!!');
            window.location.assign('form_empresa.asp?idUsu=<%=session("idUsu")%>');
        </script>
        <%
	elseIf op = " " or op = null or op = 1 then
		inserir()
	elseIf op = 2 then
        IdEmpresa = request("Id")
		desativar(IdEmpresa)
	else	
	end if
	
	function inserir()		
		on error resume next
        sql = "INSERT INTO SR_Empresa (NomeEmpresa, NomeFantasia, CNPJ, Telefone, Email, Tipo, SISBI, Status, CPFUsuarioCad, DataCadastro) VALUES ('"&request.form("NomeEmpresa")&"','"&request.form("NomeFantasia")&"','"&request.form("Cnpj")&"','"&request.form("Telefone")&"','"&request.form("Email")&"','"&request.form("Tipo")&"',"&sisbi&","&status&", '"&session("CPFUsu")&"',GETDATE())"		
        Set rs = conn.Execute(sql)
		if err <> 0 then
		%>
			<script>
            alert('Não foi possivel cadastrar!!');
            window.location.assign('form_empresa.asp');
            </script>
		<%
  		else
		%>	
			<script>
			window.location.assign('form_empresa.asp?resp=ins');
			</script>
         <%
  		end if
		rs.Close
		Set rs = Nothing		
	end function
	
	
	function desativar(id)
		on error resume next
		Set rs = conn.Execute("UPDATE SR_Empresa SET Status = 0 WHERE Id ='"&id&"'")
		Set rs2 = conn.Execute("UPDATE SR_Produto SET Status = 0 WHERE IdEmpresa = '"&id&"'")
        if err <> 0 then
		%>
			<script>
			window.location.assign('lista_empresas.asp?resp=err');
			</script>
		<%
		else
		%>
			<script>
			window.location.assign('lista_empresas.asp?resp=ok');
			</script>
        <%
		end if
		rs.close
		Set rs = Nothing
	end function 
	
%>