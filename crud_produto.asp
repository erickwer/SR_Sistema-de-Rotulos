<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<!--#include file ="lib/conexao.asp"-->
<!--#include file="upload.lib.asp"-->

<% 
Response.Charset = "ISO-8859-1"

op = request("operacao") 
Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440 'Limite de 24 minutos de execu��o de c�digo, o upload deve acontecer dentro deste tempo ou ent�o ocorre erro de limite de tempo.
Const MaxFileSize = 10240000 'Bytes. Aqui est� configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conte�dos dos formul�rios).

if session("idUsu") = null or session("idUsu") = " " then
    %>
    <script>
        alert('Não foi possivel cadastrar. Parâmetros inválidos!!');
        window.location.assign('form_empresa.asp');
    </script>
    <%

ElseIf op = 2 then
    idProduto = request("id")
    desativar(idProduto)
else	
    If Form.State = 0 Then
        
        For each Key in Form.Texts.Keys
            if Key = "Descricao" then   
                desc = Form.Texts.Item(Key)
            elseIf Key = "Registro" Then
                reg = Form.Texts.Item(Key)
            elseIf Key = "IdEmpresa" Then
                idEmp = Form.Texts.Item(Key)
            elseIF Key = "Conteudo" Then
                cont = Form.Texts.Item(Key)
            else
                end if

            'Response.Write "Elemento: " & Key & " = " & Form.Texts.Item(Key) & "<br />"
        Next
        For each Field in Form.Files.Items
            ' # Field.Filename : Nome do Arquivo que chegou.
            ' # Field.ByteArray : Dados bin�rios do arquivo, �til para subir em blobstore (MySQL).
            Field.SaveAs Server.MapPath(".") & "\upload\" & Field.FileName
            on error resume next
            sql = "INSERT INTO SR_Produto (Descricao, IdEmpresa, NumeroRegistro, EnderecoImagem, ConteudoLiquido, Status) VALUES ('"&desc&"','"&idEmp&"','"&reg&"','.\upload\"&Field.FileName&"','"&cont&"',1)"		
            Set rs = conn.Execute(sql)
            if err <> 0 then
                response.redirect("form_produto.asp?id="&idEmp&"&resp=err")
            else
                response.redirect("form_produto.asp?id="&idEmp&"&resp=ins")
            end if
            rs.Close
            Set rs = Nothing	
        Next
    End If
end if

function desativar(id)
    on error resume next
    sql = "UPDATE SR_Produto SET Status = 0 WHERE Id ='"&id&"'"
    Set rs = conn.Execute(sql)
    if err <> 0 then
    %>
        <script>
        window.location.assign('lista_produtos.asp?resp=err');
        </script>
    <%
    else
    %>
        <script>
        window.location.assign('lista_produtos.asp?resp=ok');
        </script>
    <%
    end if
    rs.close
    Set rs = Nothing
end function 
	

%>
