<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterQuotes.aspx.cs" Inherits="TarifficTechnicalAssessment.RegisterQuotes" %>

<!DOCTYPE html>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tariffic Technical Assessment - Take Home Test</title>
    <link href="Styles/Site.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.8.3.min.js"></script>
    <style type="text/css">
        .auto-style1 {
            width: 111px;
        }
        .textEntry {}
    </style>
</head>
<body class="Page">
    <form id="form1" runat="server">
    <div><%--Tariffic Technical Assessment--%>
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server"></asp:ScriptManager>
        <asp:Label ID="lblHeader" runat="server" Text="" CssClass="PageTitle"></asp:Label><br/><br/>
        <div>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                     <Triggers>

                     </Triggers>
                     <ContentTemplate>
        <asp:Panel runat="server" ID="pnlTask1" HorizontalAlign="Left" GroupingText="Task 1" Visible="True">
         <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="#009933" Visible="false"></asp:Label><br/>
        <table class="tablewidth">
            <tr>
                <td>
                    <asp:Label ID="lblAuthor" runat="server" Text="Author name:" CssClass="Fieldlable"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAuthor" runat="server" CssClass="textEntry" Width="250px"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" EnableClientScript="true"
                                            ControlToValidate="txtAuthor" ValidationGroup="RequiredFields" CssClass="ReqFieldlable"
                                            SetFocusOnError="true" ErrorMessage="Author name is a required field." />
                </td>
               
            </tr>
            <tr>
                <td>
                     <asp:Label ID="lblQuote" runat="server" Text="Quote:" CssClass="Fieldlable"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtQuote" runat="server" CssClass="textEntry" Width="250px" AutoPostBack="true" OnTextChanged="txtQuote_TextChanged"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                                            ControlToValidate="txtQuote" ValidationGroup="RequiredFields" CssClass="ReqFieldlable"
                                            SetFocusOnError="true" ErrorMessage="Quote is a required field." />
                </td>
            </tr>
            <tr>
                <td>
                     <asp:Label ID="lblMoodOrEmotion" runat="server" Text="Mood or emotion:" CssClass="Fieldlable"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtMoodOrEmotion" runat="server" CssClass="textEntry" Width="250px"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                                            ControlToValidate="txtMoodOrEmotion" ValidationGroup="RequiredFields" CssClass="ReqFieldlable"
                                            SetFocusOnError="true" ErrorMessage="Mood or emotion is a required field." />
                </td>
            </tr>
             <tr>
                <td>
                     <asp:Label ID="lblQuoteSource" runat="server" Text="Source of quote:" CssClass="Fieldlable"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtQuoteSource" runat="server" CssClass="textEntry" Width="250px"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
                                            ControlToValidate="txtQuoteSource" ValidationGroup="RequiredFields" CssClass="ReqFieldlable"
                                            SetFocusOnError="true" ErrorMessage="Source of quote is a required field." />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                     <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="submitButton" OnClick="btnSubmit_Click"/> &nbsp;
                       <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancelButton" OnClick="btnCancel_Click" />
                </td>
            </tr>
        </table><br/>
            <p>
                <asp:Label ID="lblProcessedQuote" runat="server" Text="Processed Quote:" Visible="false" CssClass="Fieldlable"></asp:Label>
                 <asp:Label ID="lblValue" runat="server" Text=""></asp:Label>
            </p><br/>
       </asp:Panel><br/>
        <asp:Panel ID="pnlCountsPerMood" runat="server" GroupingText="Display Counts Per Mood">
                <asp:GridView ID="grvCountsPerMood" runat="server" AutoGenerateColumns="False" EmptyDataText="No counts data found..." HorizontalAlign="Left" RowStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" AlternatingRowStyle-HorizontalAlign="Center" BorderStyle="Ridge" BorderColor="White" Width="10%" DataSourceID="dsCountsPerMood">
                      <Columns>
                            <asp:BoundField DataField="Mood" HeaderText="Mood">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left"/>
                            </asp:BoundField>
                          <asp:BoundField DataField="Count" HeaderText="Counts">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                          </Columns>
                    <AlternatingRowStyle />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                    <PagerStyle BackColor="#284775" ForeColor="White" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:SqlDataSource ID="dsCountsPerMood" runat="server" ConnectionString="<%$ ConnectionStrings:TarifficTADBConString %>" SelectCommand="SELECT [MoodOrEmotion] As Mood,COUNT(*) As [Count]
FROM [dbo].[Quotes]
GROUP BY [MoodOrEmotion]"></asp:SqlDataSource>
            </asp:Panel><br/>
     <asp:Panel ID="pnlSearch" runat="server" GroupingText="Search capabilities">
             <table style="margin-left: 0px">
                        <tr>
                            <td>
                                <asp:Label ID="lbFilter" runat="server" Text="Search:" CssClass="Fieldlable" Visible="true"></asp:Label>
                                <input type='text' onkeyup='Filter(this,1);' id="txtSearch" class="textEntry" width="250px" runat="server" visible="true" />
                            </td>
                        </tr>
                    </table>
             <asp:GridView ID="grdSearch" runat="server" AutoGenerateColumns="False" EmptyDataText="No quotes data found..." HorizontalAlign="Left" RowStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" AlternatingRowStyle-HorizontalAlign="Center" BorderStyle="Ridge" BorderColor="White" Width="30%" DataSourceID="dsSearch">
                      <Columns>
                            <asp:BoundField DataField="Mood" HeaderText="Mood">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left"/>
                            </asp:BoundField>
                          <asp:BoundField DataField="Text" HeaderText="Text">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left"/>
                            </asp:BoundField>
                          </Columns>
                    <AlternatingRowStyle />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                    <PagerStyle BackColor="#284775" ForeColor="White" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
             <asp:SqlDataSource ID="dsSearch" runat="server" ConnectionString="<%$ ConnectionStrings:TarifficTADBConString %>" SelectCommand="SELECT [MoodOrEmotion] As Mood,Quote As [Text]
FROM [dbo].[Quotes]"></asp:SqlDataSource>
      </asp:Panel><br/>
        <asp:Panel runat="server" ID="pnlTask2" HorizontalAlign="Left" GroupingText="Task 2" Visible="True">
              <table class="tablewidth">
                  <tr>
                      <th>
                          Demonstration Area
                      </th>
                  </tr>
            <tr>
                <td class="auto-style1">
                       <asp:TextBox ID="txtDemonstration" runat="server" TextMode="MultiLine" CssClass="textEntry" Width="395px" Height="100px"></asp:TextBox>
                </td>
             </tr>
             </table>
        </asp:Panel>
<table>
    <tr>
        <td>
            <asp:Button ID="btnPost" runat="server" Text="Post Comment" OnClick="btnPost_Click" />
        </td>
        <td>

        </td>
    </tr>
</table>


</ContentTemplate>
</asp:UpdatePanel>
        </div>
    </div>
    </form>
       <script type="text/javascript">
           //for serching gridview on keyup
           function Filter(Obj, GrvNo) {
               var grid;
               if (GrvNo == 1) {
                   grid = document.getElementById('<% =grdSearch.ClientID%>');
            }
            var terms = Obj.value.toUpperCase();
            var cellNr = 0; //your grid cellindex like name
            var ele;
            for (var r = 1; r < grid.rows.length; r++) {
                ele = grid.rows[r].cells[cellNr].innerHTML.replace(/<[^>]+>/g, "");
                for (var col = 1; col < grid.rows[r].cells.length - 1; col++) {
                    ele += grid.rows[r].cells[col].innerHTML.replace(/<[^>]+>/g, "");
                }
                if (ele.toUpperCase().indexOf(terms) >= 0)
                    grid.rows[r].style.display = '';
                else grid.rows[r].style.display = 'none';
            }
        }

        if (typeof jQuery != 'undefined') {
            $(function () {
                $("[id*=grdSearch] td").hover(function () {
                    $("td", $(this).closest("tr")).addClass("hover_row");
                }, function () {
                    $("td", $(this).closest("tr")).removeClass("hover_row");
                });
            });

        } else {
            alert("jQuery library is not loaded!");
        }

    </script>
</body>
</html>
