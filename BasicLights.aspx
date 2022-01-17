<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="BasicLights.aspx.cs" Inherits="Lights.Feed" %>

<html> 
    <body>
     <form id="form1" runat="server">
     <script  type="text/javascript">

         function reload() {
             setTimeout('reloadImg("refresh")', 1000)
         };

     </script>
      <div ><h1>Change the lights on the [thing]!</h1>  
       
       
               <div>
              If you have a webcam, your image goes here.
          </div>
    

 <div>
    
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1" ClientIDMode="Static" DefaultMode="Edit" onitemupdated="FormView1_ItemUpdated" width="100%" RowStyle-HorizontalAlign="Center">
                <EditItemTemplate>
                    <table style="vertical-align: top">
                        <tr>
                            <td style="vertical-align: top">
                                
                            
                      <h5>Local Current Light Color:</h5>
                <p> Click the box to change colors.</p>
     <!The datalist attached to the TextBox contains all of the colors we tried that seemed to be compatible with the NeoPixels. You can change this list accordingly.--> 
  <asp:TextBox Type="color" id="colorChangeBG" onchange="getRGBColor(this)" list="presetColors" runat="server"  Text='<%# Bind("Setting") %>' Height="75px" Width="75px" BorderWidth="3px" BorderStyle="Groove" ToolTip="Our Current Light Color. Click here to change colors."></asp:TextBox>
      <datalist id="presetColors" >
    <option>#ff0000</option>    
          <option>#ffffff</option>    
          <option>#ff0000</option>    
          <option>#0000FF</option>    
          <option>#FFFF00</option>
          <option>#00FFFF</option>    
          <option>#FF00FF</option>
          <option>#C0C0C0</option>
          <option>#008000</option>
          <option>#800080</option>
          <option>#000080</option>
          <option>#8B0000</option>
          <option>#B22222</option>
          <option>#DC143C</option>
          <option>#FF6347</option>
          <option>#FF7F50</option>
          <option>#CD5C5C</option>
          <option>#F08080</option>
          <option>#E9967A</option>
          <option>#FA8072</option>
          <option>#FFA07A</option>
          <option>#FF4500</option>
          <option>#FF8C00</option>
          <option>#FFA500</option>
          <option>#FFD700</option>
          <option>#B8860B</option>
          <option>#DAA520</option>
          <option>#EEE8AA</option>
          <option>#BDB76B</option>
          <option>#F0E68C</option>
          <option>#FFFF00</option>
          <option>#9ACD32</option>
          <option>#7CFC00</option>
          <option>#7FFF00</option>
          <option>#ADFF2F</option>
          <option>#006400</option>
          <option>#008000</option>
          <option>#228B22</option>
          <option>#00FF00</option>
          <option>#32CD32</option>
          <option>#90EE90</option>
          <option>#98FB98</option>
          <option>#9ACD32</option>
          <option>#8FBC8F</option>
          <option>#00FA9A</option>
          <option>#00FF7F</option>
          <option>#2E8B57</option>
          <option>#66CDAA</option>
          <option>#3CB371</option>
          <option>#20B2AA</option>
          <option>#2F4F4F</option>
          <option>#008080</option>
          <option>#008B8B</option>
          <option>#00FFFF</option>
          <option>#00FFFF</option>
          <option>#E0FFFF</option>
          <option>#00CED1</option>
          <option>#40E0D0</option>
          <option>#48D1CC</option>
          <option>#AFEEEE</option>
          <option>#7FFFD4</option>
          <option>#B0E0E6</option>
          <option>#5F9EA0</option>
          <option>#4682B4</option>
          <option>#6495ED</option>
          <option>#00BFFF</option>
          <option>#1E90FF</option>
          <option>#ADD8E6</option>
          <option>#87CEEB</option>
          <option>#87CEFA</option>
          <option>#191970</option>
          <option>#000080</option>
          <option>#00008B</option>
          <option>#0000CD</option>
          <option>#0000FF</option>
          <option>#4169E1</option>
          <option>#8A2BE2</option>
          <option>#4B0082</option>
          <option>#483D8B</option>
          <option>#6A5ACD</option>
          <option>#7B68EE</option>
          <option>#9370DB</option>
          <option>#8B008B</option>
          <option>#9400D3</option>
          <option>#9932CC</option>
          <option>#BA55D3</option>
          <option>#D8BFD8</option>
          <option>#DDA0DD</option>
          <option>#EE82EE</option>
          <option>#FF00FF</option>
          <option>#DA70D6</option>
          <option>#C71585</option>
          <option>#DB7093</option>
          <option>#FF1493</option>
          <option>#FF69B4</option>
          <option>#FFB6C1</option>
          <option>#FFC0CB</option>
          <option>#FAEBD7</option>
          <option>#F5F5DC</option>
          <option>#FFE4C4</option>
          <option>#FFEBCD</option>
          <option>#F5DEB3</option>
          <option>#FFF8DC</option>
          <option>#FFFACD</option>
          <option>#FAFAD2</option>
          <option>#FFFFE0</option>
          <option>#D2691E</option>
          <option>#CD853F</option>
          <option>#F4A460</option>
          <option>#DEB887</option>
          <option>#D2B48C</option>
          <option>#BC8F8F</option>
          <option>#FFE4B5</option>
          <option>#FFDEAD</option>
          <option>#FFDAB9</option>
          <option>#FFE4E1</option>
          <option>#FFF0F5</option>
          <option>#FAF0E6</option>
          <option>#FDF5E6</option>
          <option>#FFEFD5</option>
          <option>#FFF5EE</option>
          <option>#F5FFFA</option>
          <option>#708090</option>
          <option>#778899</option>
          <option>#B0C4DE</option>
          <option>#E6E6FA</option>
          <option>#FFFAF0</option>
          <option>#F0F8FF</option>
          <option>#F8F8FF</option>
          <option>#F0FFF0</option>
          <option>#FFFFF0</option>
          <option>#F0FFFF</option>
          <option>#000000</option>
          <option>#A9A9A9</option>
          <option>#C0C0C0</option>
          <option>#D3D3D3</option>
          <option>#DCDCDC</option>
          <option>#F5F5F5</option>
          <option>#FFFFFF</option>
</datalist>
     <br />
  <asp:Button ID="UpdateButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Send" Height="75px" Width="75px"  Font-Bold="True" BackColor="Silver" ToolTip="Send" />
      &nbsp;
      <asp:Button ID="UpdateButton2" runat="server" CausesValidation="True" CommandName="Cancel" CssClass="Button" Height="75px" Text="Cancel" Width="75px" BackColor="White" ToolTip="Cancel" />
 </td>
                           
                        
                             <td>
                               &nbsp; &nbsp;
                                 </td>
                            <td style="vertical-align: top">
                               <h5> Current CheerLights Color:</h5>
                                <p >&nbsp;</p>
                                <iframe src="https://cheerlights.com/widgets/color.html" width="75" height="75" scrolling="no" style="border:1px solid"></iframe>
                              <p >&nbsp;</p>
                                <p class="copy">The lights in the picture<br />should be one of these two colors.</p>
                                 </td>
                        </tr>
                    </table>
                            </div>
                  
                </EditItemTemplate>
                <InsertItemTemplate>
                  
                </InsertItemTemplate>
                <ItemTemplate>
                   
                </ItemTemplate>

<RowStyle HorizontalAlign="Center"></RowStyle>
        </asp:FormView>
               
  </div>
       <p>&nbsp;</p>
            <p class="copy">The color picker is generated by your browser, and may vary. Just click on the color box to start. Find a color, select it, then press the SEND button to change the color. If we have a camera on the object, it may take up to a minute to see the change. Patience, padawan.</p>
            <p class="copy">So, how does this work? Magic. Pure magic. And cats.</p>
            &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ Put your connection string here %>" DeleteCommand="DELETE FROM [Lights] WHERE [ID] = @ID" SelectCommand="SELECT * FROM [Lights] WHERE ([Node] = @Node)" UpdateCommand="UPDATE Lights SET Setting = @Setting, RGB = @RGB WHERE (Node = @Node)">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
             
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="CheerLights" Name="Node" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Setting" Type="String" />
                <asp:Parameter Name="RGB" />
                <asp:Parameter DefaultValue="NodeName" Name="Node" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        

  	


</div>
<!--Code to autorefresh the page. You may or may not want this. -->
<script type="text/javascript">
    function autoRefreshPage() {
        window.location = window.location.href;
    }
    setInterval('autoRefreshPage()', 60000);
</script>
     <script type="text/javascript">
         var nods = document.getElementsByClassName('NO-CACHE');
         for (var i = 0; i < nods.length; i++) {
             nods[i].attributes['src'].value += "?a=" + Math.random();
         }
     </script>
     </form>
        </body>
</html>
