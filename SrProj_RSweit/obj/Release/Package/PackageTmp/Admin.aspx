<%@ Page Title="Admin Section" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="SrProj_RSweit.Admin" %>

<asp:Content ID="Content" ContentPlaceHolderID="main" runat="server">
    <%-- Bootstrap divs to organize data --%>
    <div class="container-fluid">
        <h2 class="display-2 text-light text-center">Customer List</h2>
        <div class="row justify-content-center">

            <%-- Gridview for Users --%>
            <asp:GridView HorizontalAlign="Center" CssClass="text-center" ID="CustomerGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID"
                DataSourceID="SqlDataSource1" AllowPaging="true" PageSize="10" BorderStyle="Solid" BorderWidth="3px" ForeColor="#333333">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            &nbsp;<asp:Button ID="btnDelete" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this user? This action cannot be undone!');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UserID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="UserID" />
                    <asp:BoundField DataField="UserEmail" HeaderText="Email" SortExpression="UserEmail" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserFirstName" HeaderText="First Name" SortExpression="UserFirstName" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserLastName" HeaderText="Last Name" SortExpression="UserLastName" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserAddress1" HeaderText="Address Line 1" SortExpression="UserAddress1" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserAddress2" HeaderText="Address Line 2" SortExpression="UserAddress2" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserCity" HeaderText="City" SortExpression="UserCity" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserState" HeaderText="State" SortExpression="UserState" />
                    <asp:BoundField ConvertEmptyStringToNull="false" DataField="UserZip" HeaderText="Zip" SortExpression="UserZip" />
                    <asp:CheckBoxField DataField="UserEmailVerified" HeaderText="EmailVerified" SortExpression="UserEmailVerified" />
                    <asp:CheckBoxField DataField="UserIsAdmin" HeaderText="IsAdmin" SortExpression="UserIsAdmin" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Left" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>

            <%-- SQL data attached to users --%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SrProjConnectionString %>"
                DeleteCommand="DELETE FROM [users] WHERE [UserID] = @UserID"
                InsertCommand="INSERT INTO [users] ([UserEmail], [UserFirstName], [UserLastName], [UserAddress1], [UserAddress2], [UserCity], [UserState], [UserZip], [UserEmailVerified], [UserIsAdmin]) VALUES (@UserEmail, @UserFirstName, @UserLastName, @UserAddress1, @UserAddress2, @UserCity, @UserState, @UserZip, @UserEmailVerified, @UserIsAdmin)"
                SelectCommand="SELECT [UserID], [UserEmail], [UserFirstName], [UserLastName], [UserAddress1], [UserAddress2], [UserCity], [UserState], [UserZip], [UserEmailVerified], [UserIsAdmin] FROM [users]"
                UpdateCommand="UPDATE [users] SET [UserEmail] = @UserEmail, [UserFirstName] = @UserFirstName, [UserLastName] = @UserLastName, [UserAddress1] = @UserAddress1, [UserAddress2] = @UserAddress2, [UserCity] = @UserCity, [UserState] = @UserState, [UserZip] = @UserZip, [UserEmailVerified] = @UserEmailVerified, [UserIsAdmin] = @UserIsAdmin WHERE [UserID] = @UserID">
                <DeleteParameters>
                    <asp:Parameter Name="UserID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserEmail" Type="String" />
                    <asp:Parameter Name="UserFirstName" Type="String" />
                    <asp:Parameter Name="UserLastName" Type="String" />
                    <asp:Parameter Name="UserAddress1" Type="String" />
                    <asp:Parameter Name="UserAddress2" Type="String" />
                    <asp:Parameter Name="UserCity" Type="String" />
                    <asp:Parameter Name="UserState" Type="String" />
                    <asp:Parameter Name="UserZip" Type="String" />
                    <asp:Parameter Name="UserEmailVerified" Type="Boolean" />
                    <asp:Parameter Name="UserIsAdmin" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="UserEmail" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserFirstName" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserLastName" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserAddress1" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserAddress2" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserCity" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserState" Type="String" />
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="UserZip" Type="String" />
                    <asp:Parameter Name="UserEmailVerified" Type="Boolean" />
                    <asp:Parameter Name="UserIsAdmin" Type="Boolean" />
                    <asp:Parameter Name="UserID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>

        <%-- Bootstrap divs for data organization --%>
        <h2 class="display-2 text-light text-center">Product List</h2>
        <div class="row justify-content-right" style="width: 100%; overflow: scroll;">

            <%-- Gridview for products --%>
            <asp:GridView CssClass="text-center" ID="ProductGridView" runat="server" DataSourceID="ProductSQL"
                BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" ForeColor="Black"
                AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ProductID" ShowFooter="True">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="NewAdd" runat="server" ForeColor="Black" Text="Add" OnClick="BtnAdd_Click" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID" SortExpression="ProductID">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductID") %>'></asp:Label>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewID" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ProductID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" SortExpression="ProductName">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ProductName") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewName" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price" SortExpression="ProductPrice">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ProductPrice") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewPrice" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("ProductPrice") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Weight" SortExpression="ProductWeight">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ProductWeight") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewWeight" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("ProductWeight") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cart Desc." SortExpression="ProductCartDesc">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ProductCartDesc") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewCartDesc" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("ProductCartDesc") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Short Desc." SortExpression="ProductShortDesc">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ProductShortDesc") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewShortDesc" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("ProductShortDesc") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Long Desc." SortExpression="ProductLongDesc">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("ProductLongDesc") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewLongDesc" runat="server" ForeColor="Black"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <div style="width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("ProductLongDesc") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thumb Img" SortExpression="ProductThumb">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("ProductThumb") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:FileUpload ID="NewThmbUp" runat="server" ForeColor="Black" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("ProductThumb") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Image" SortExpression="ProductImage">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("ProductImage") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:FileUpload ID="NewImgUp" runat="server" ForeColor="Black" />
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("ProductImage") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Heat" SortExpression="ProductHeat">
                        <EditItemTemplate>
                            <asp:DropDownList ID="HeatDropdown" runat="server" SelectedValue='<%# Bind("ProductHeat") %>'>
                                <asp:ListItem>Choose Heat</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/X.png">X</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/XX.png">XX</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/XXX.png">XXX</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/XXXX.png">XXXX</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="HeatDropdown" runat="server">
                                <asp:ListItem>Choose Heat</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/X.png">X</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/XX.png">XX</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/XXX.png">XXX</asp:ListItem>
                                <asp:ListItem Value="/Media/HeatImg/XXXX.png">XXXX</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("ProductHeat") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Product Category" SortExpression="ProductCategoryID">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("ProductCategoryID") %>'>
                                <asp:ListItem>Select Category</asp:ListItem>
                                <asp:ListItem Value="1">Sauce</asp:ListItem>
                                <asp:ListItem Value="2">Shirt</asp:ListItem>
                                <asp:ListItem Value="3">Hat</asp:ListItem>
                                <asp:ListItem Value="4">Decal</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="CategoryDropdown" runat="server">
                                <asp:ListItem>Select Category</asp:ListItem>
                                <asp:ListItem Value="1">Sauce</asp:ListItem>
                                <asp:ListItem Value="2">Shirt</asp:ListItem>
                                <asp:ListItem Value="3">Hat</asp:ListItem>
                                <asp:ListItem Value="4">Decal</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("ProductCategoryID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="In Stock" SortExpression="ProductStock">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("ProductStock") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="NewInStock" runat="server"></asp:TextBox>
                        </FooterTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label12" runat="server" Text='<%# Bind("ProductStock") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="ProductLive" HeaderText="IS Live" SortExpression="ProductLive" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" CssClass="text-center" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>

            <%-- SQL data attached to products --%>
            <asp:SqlDataSource ID="ProductSQL" runat="server" ConnectionString="<%$ ConnectionStrings:SrProjConnectionString %>"
                DeleteCommand="DELETE FROM [products] WHERE [ProductID] = @ProductID"
                InsertCommand="INSERT INTO [products] ([ProductID], [ProductName], [ProductPrice], [ProductWeight], [ProductCartDesc], [ProductShortDesc], [ProductLongDesc], [ProductThumb], [ProductImage], [ProductHeat], [ProductCategoryID], [ProductStock], [ProductLive]) VALUES (@ProductID, @ProductName, @ProductPrice, @ProductWeight, @ProductCartDesc, @ProductShortDesc, @ProductLongDesc, @ProductThumb, @ProductImage, @ProductHeat, @ProductCategoryID, @ProductStock, @ProductLive)"
                SelectCommand="SELECT [ProductID], [ProductName], [ProductPrice], [ProductWeight], [ProductCartDesc], [ProductShortDesc], [ProductLongDesc], [ProductThumb], [ProductImage], [ProductHeat], [ProductCategoryID], [ProductStock], [ProductLive] FROM [products]"
                UpdateCommand="UPDATE [products] SET [ProductName] = @ProductName, [ProductPrice] = @ProductPrice, [ProductWeight] = @ProductWeight, [ProductCartDesc] = @ProductCartDesc, [ProductShortDesc] = @ProductShortDesc, [ProductLongDesc] = @ProductLongDesc, [ProductThumb] = @ProductThumb, [ProductImage] = @ProductImage, [ProductHeat] = @ProductHeat, [ProductCategoryID] = @ProductCategoryID, [ProductStock] = @ProductStock, [ProductLive] = @ProductLive WHERE [ProductID] = @ProductID">
                <DeleteParameters>
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ProductID" Type="Int32" />
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="ProductPrice" Type="Double" />
                    <asp:Parameter Name="ProductWeight" Type="Double" />
                    <asp:Parameter Name="ProductCartDesc" Type="String" />
                    <asp:Parameter Name="ProductShortDesc" Type="String" />
                    <asp:Parameter Name="ProductLongDesc" Type="String" />
                    <asp:Parameter Name="ProductThumb" Type="String" />
                    <asp:Parameter Name="ProductImage" Type="String" />
                    <asp:Parameter Name="ProductHeat" Type="String" />
                    <asp:Parameter Name="ProductCategoryID" Type="Int32" />
                    <asp:Parameter Name="ProductStock" Type="Double" />
                    <asp:Parameter Name="ProductLive" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProductName" Type="String" />
                    <asp:Parameter Name="ProductPrice" Type="Double" />
                    <asp:Parameter Name="ProductWeight" Type="Double" />
                    <asp:Parameter Name="ProductCartDesc" Type="String" />
                    <asp:Parameter Name="ProductShortDesc" Type="String" />
                    <asp:Parameter Name="ProductLongDesc" Type="String" />
                    <asp:Parameter Name="ProductThumb" Type="String" />
                    <asp:Parameter Name="ProductImage" Type="String" />
                    <asp:Parameter Name="ProductHeat" Type="String" />
                    <asp:Parameter Name="ProductCategoryID" Type="Int32" />
                    <asp:Parameter Name="ProductStock" Type="Double" />
                    <asp:Parameter Name="ProductLive" Type="Boolean" />
                    <asp:Parameter Name="ProductID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>

        <%-- Bootstrap divs for data organization --%>
        <h2 class="display-2 text-light text-center">Order List</h2>
        <div class="row justify-content-right" style="width: 100%; overflow: scroll;">
            <%-- Gridview for Orders --%>
            <asp:GridView CssClass="text-center" runat="server" ID="gvOrder" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow"
                BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="OrderID" DataSourceID="orderSQL" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="OrderID" HeaderText="OrderID" InsertVisible="False" ReadOnly="True" SortExpression="OrderID" />
                    <asp:BoundField DataField="OrderUserID" HeaderText="OrderUserID" SortExpression="OrderUserID" />
                    <asp:BoundField DataField="OrderAmount" HeaderText="OrderAmount" SortExpression="OrderAmount" />
                    <asp:BoundField DataField="OrderShipName" HeaderText="OrderShipName" SortExpression="OrderShipName" />
                    <asp:BoundField DataField="OrderShipAddress" HeaderText="OrderShipAddress" SortExpression="OrderShipAddress" />
                    <asp:BoundField DataField="OrderShipAddress2" HeaderText="OrderShipAddress2" SortExpression="OrderShipAddress2" />
                    <asp:BoundField DataField="OrderCity" HeaderText="OrderCity" SortExpression="OrderCity" />
                    <asp:BoundField DataField="OrderState" HeaderText="OrderState" SortExpression="OrderState" />
                    <asp:BoundField DataField="OrderZip" HeaderText="OrderZip" SortExpression="OrderZip" />
                    <asp:BoundField DataField="OrderPhone" HeaderText="OrderPhone" SortExpression="OrderPhone" />
                    <asp:BoundField DataField="OrderShipping" HeaderText="OrderShipping" SortExpression="OrderShipping" />
                    <asp:BoundField DataField="OrderTax" HeaderText="OrderTax" SortExpression="OrderTax" />
                    <asp:BoundField DataField="OrderEmail" HeaderText="OrderEmail" SortExpression="OrderEmail" />
                    <asp:BoundField DataField="OrderDate" HeaderText="OrderDate" SortExpression="OrderDate" />
                    <asp:CheckBoxField DataField="OrderShipped" HeaderText="OrderShipped" SortExpression="OrderShipped" />
                    <asp:BoundField DataField="OrderTrackingNumber" HeaderText="OrderTrackingNumber" SortExpression="OrderTrackingNumber" />
                </Columns>
                <FooterStyle BackColor="Tan" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
            </asp:GridView>
            <%-- SQL data attached to orders --%>
            <asp:SqlDataSource runat="server" ID="orderSQL" ConnectionString="<%$ ConnectionStrings:SrProjConnectionString %>"
                DeleteCommand="DELETE FROM [orders] WHERE [OrderID] = @OrderID"
                InsertCommand="INSERT INTO [orders] ([OrderUserID], [OrderAmount], [OrderShipName], [OrderShipAddress], [OrderShipAddress2], [OrderCity], [OrderState], [OrderZip], [OrderPhone], [OrderShipping], [OrderTax], [OrderEmail], [OrderDate], [OrderShipped], [OrderTrackingNumber]) VALUES (@OrderUserID, @OrderAmount, @OrderShipName, @OrderShipAddress, @OrderShipAddress2, @OrderCity, @OrderState, @OrderZip, @OrderPhone, @OrderShipping, @OrderTax, @OrderEmail, @OrderDate, @OrderShipped, @OrderTrackingNumber)"
                SelectCommand="SELECT * FROM [orders]"
                UpdateCommand="UPDATE [orders] SET [OrderUserID] = @OrderUserID, [OrderAmount] = @OrderAmount, [OrderShipName] = @OrderShipName, [OrderShipAddress] = @OrderShipAddress, [OrderShipAddress2] = @OrderShipAddress2, [OrderCity] = @OrderCity, [OrderState] = @OrderState, [OrderZip] = @OrderZip, [OrderPhone] = @OrderPhone, [OrderShipping] = @OrderShipping, [OrderTax] = @OrderTax, [OrderEmail] = @OrderEmail, [OrderDate] = getdate(), [OrderShipped] = @OrderShipped, [OrderTrackingNumber] = @OrderTrackingNumber WHERE [OrderID] = @OrderID">
                <DeleteParameters>
                    <asp:Parameter Name="OrderID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="OrderUserID" Type="Int32" />
                    <asp:Parameter Name="OrderAmount" Type="Double" />
                    <asp:Parameter Name="OrderShipName" Type="String" />
                    <asp:Parameter Name="OrderShipAddress" Type="String" />
                    <asp:Parameter Name="OrderShipAddress2" Type="String" />
                    <asp:Parameter Name="OrderCity" Type="String" />
                    <asp:Parameter Name="OrderState" Type="String" />
                    <asp:Parameter Name="OrderZip" Type="String" />
                    <asp:Parameter Name="OrderPhone" Type="String" />
                    <asp:Parameter Name="OrderShipping" Type="Double" />
                    <asp:Parameter Name="OrderTax" Type="Double" />
                    <asp:Parameter Name="OrderEmail" Type="String" />
                    <asp:Parameter Name="OrderDate" DbType="DateTime2" />
                    <asp:Parameter Name="OrderShipped" Type="Boolean" />
                    <asp:Parameter Name="OrderTrackingNumber" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="OrderUserID" Type="Int32" />
                    <asp:Parameter Name="OrderAmount" Type="Double" />
                    <asp:Parameter Name="OrderShipName" Type="String" />
                    <asp:Parameter Name="OrderShipAddress" Type="String" />
                    <asp:Parameter Name="OrderShipAddress2" Type="String" />
                    <asp:Parameter Name="OrderCity" Type="String" />
                    <asp:Parameter Name="OrderState" Type="String" />
                    <asp:Parameter Name="OrderZip" Type="String" />
                    <asp:Parameter Name="OrderPhone" Type="String" />
                    <asp:Parameter Name="OrderShipping" Type="Double" />
                    <asp:Parameter Name="OrderTax" Type="Double" />
                    <asp:Parameter Name="OrderEmail" Type="String" />
                    <asp:Parameter Name="OrderDate" DbType="DateTime2" />
                    <asp:Parameter Name="OrderShipped" Type="Boolean" />
                    <asp:Parameter Name="OrderTrackingNumber" Type="String" />
                    <asp:Parameter Name="OrderID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <%-- Bootstrap organization --%>
        <h2 class="display-2 text-light text-center">Order Details</h2>
        <div class="row justify-content-center">
            <%-- Controls to display order specific details --%>
            <asp:TextBox runat="server" ID="txtOrderDetail"></asp:TextBox>
            <asp:Button runat="server" ID="btnDetail" Text="Submit" CssClass="btn-secondary" OnClick="btnDetail_Click" />
            <br />
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger"></asp:Label>
        </div>
        <div class="row justify-content-center">
            <%-- Gridview for order details --%>
            <asp:GridView CssClass="mb-5" runat="server" ID="gvOrderDetail" CellPadding="4" ForeColor="#333333" GridLines="Vertical">
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
