<%@ Page Title="Check Out" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="SrProj_RSweit.Checkout" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%-- Bootstrap format and organization --%>
    <div class="container-fluid">
        <h2 class="display-2 text-light text-center">Check Out</h2>
        <div class="row justify-content-center">
            <div class=" col-sm-7">
                <div class="card" style="padding: 0%; margin-bottom: 10px; margin-top: 10px;">
                    <h4 class="card-header text-light cardhead">Your Order:</h4>
                    <div class="card-body">
                        <%-- Gridview for Cart display --%>
                        <asp:GridView ShowHeader="false" DataKeyNames="CartID" ID="gvCart" runat="server" AutoGenerateColumns="false"
                            GridLines="Horizontal" OnRowDeleting="gvCart_RowDeleting" CssClass="mb-3">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button CssClass="btn btn-danger" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:Button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Bind("CartID") %>' ID="TextBox3"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfID" Value='<%# Bind("CartID") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ProductThumb") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Image ID="Label1" runat="server" ImageUrl='<%# Bind("ProductThumb") %>' Height="200px" Width="125"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Bind("ProductCartDesc") %>' ID="TextBox4"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("ProductCartDesc") %>' ID="Label3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Bind("CartPrice") %>' ID="TextBox5"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text="Price:"></asp:Label>
                                        <asp:Label runat="server" Text='<%#"$" + Eval("CartPrice") + ".00" %>' ID="Label4"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Quantity">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CartQuantity") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text="Quantity:"></asp:Label>
                                        <asp:Label ID="txtQuantity" runat="server" Text='<%# Bind("CartQuantity") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblSub" runat="server" CssClass="h4"></asp:Label>
                        <br>
                        <asp:Label ID="lblTax" runat="server" CssClass="h4"></asp:Label>
                        <br>
                        <asp:Label ID="lblShip" runat="server" CssClass="h4"></asp:Label>
                        <hr style=" border-style:inset; border-width: 1px;">
                        <asp:Label ID="lblTotal" runat="server" CssClass="h4"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <%-- Bootstrap format and organization --%>
        <div class="row justify-content-center">
            <div class="col-sm-7">
                <div class="card-group">
                    <div class="card" style="padding: 0%; margin-bottom: 10px;">
                        <h4 id="hdProdName" runat="server" class="card-header text-light cardhead">Your Shipping Address:</h4>
                        <div class="card-body">
                            <%-- Left half of card that hold checkbox and current user information --%>
                            <ul class="list-unstyled">
                                <li>
                                    <asp:CheckBox runat="server" ID="cbAddress" OnCheckedChanged="cbAddress_CheckedChanged" Text="Same as Billing" AutoPostBack="true" />
                                </li>
                                <li>
                                    <h4 class="card-title">First name:</h4>
                                    <asp:RequiredFieldValidator ID="fnameError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtFname" runat="server" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtFname" runat="server" CssClass="form-control" />
                                </li>

                                <li>
                                    <h4 class="card-title">Last name:</h4>
                                    <asp:RequiredFieldValidator ID="lnameError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtLname" runat="server" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtLname" runat="server" CssClass="form-control" />
                                </li>

                                <li>
                                    <h4 class="card-title">Address Line 1:</h4>
                                    <asp:RequiredFieldValidator ID="addressError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtAddressLnOne" runat="server" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtAddressLnOne" runat="server" CssClass="form-control" />
                                </li>

                                <li>
                                    <h4 class="card-title">Address Line 2 (Optional):</h4>

                                    <asp:TextBox ID="txtAddressLnTwo" runat="server" CssClass="form-control" />
                                </li>

                                <li>
                                    <h4 class="card-title">City:</h4>
                                    <asp:RequiredFieldValidator ID="cityError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtCity" runat="server" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
                                </li>

                                <li>
                                    <h4 class="card-title">State:</h4>
                                    <asp:RequiredFieldValidator ID="stateError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtState" runat="server" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtState" runat="server" CssClass="form-control" />
                                </li>

                                <li>
                                    <h4 class="card-title">Zip:</h4>
                                    <asp:RequiredFieldValidator ID="zipError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtZip" runat="server" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" />
                                </li>
                                <li>
                                    <h4 class="card-title">Phone Number:</h4>
                                    <asp:RequiredFieldValidator ID="phoneError" ErrorMessage="Required" Display="Dynamic" ForeColor="Red"
                                        ControlToValidate="txtPhone" runat="server" ValidationGroup="customer" />

                                    <asp:RegularExpressionValidator runat="server" Display="Dynamic"
                                        ValidationExpression="^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$"
                                        ControlToValidate="txtPhone" ForeColor="Red" ErrorMessage="Must be a phone number between 7-10 digits" ValidationGroup="customer" />

                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                                </li>
                            </ul>
                        </div>
                    </div>
                    <%-- Bootstrap format and organization --%>
                    <div class="card" style="padding: 0%; margin-bottom: 10px;">
                        <h4 id="h1" runat="server" class="card-header text-light cardhead">Car Information:</h4>
                        <div class="card-body">
                            <%-- Right half of card that holds fields for current user card information --%>
                            <ul class="list-unstyled">
                                <li>
                                    <asp:RadioButtonList ID="rdbCCType" runat="server">
                                        <asp:ListItem Value="PP">PayPal</asp:ListItem>
                                        <asp:ListItem Value="Credit Card">Credit Card</asp:ListItem>
                                    </asp:RadioButtonList>
                                </li>
                                <li>
                                    <h4 class="card-title">Card Number:</h4>
                                    <asp:TextBox ID="txtCC" runat="server" CssClass="form-control"></asp:TextBox>
                                </li>
                                <li>
                                    <h4 class="card-title">Card Expiration:</h4>
                                    <asp:DropDownList ID="txtCCMonth" runat="server" EnableViewState="False">
                                        <asp:ListItem Value="1">January - 01</asp:ListItem>
                                        <asp:ListItem Value="2">February - 02</asp:ListItem>
                                        <asp:ListItem Value="3">March - 03</asp:ListItem>
                                        <asp:ListItem Value="4">April - 04</asp:ListItem>
                                        <asp:ListItem Value="5">May - 05</asp:ListItem>
                                        <asp:ListItem Value="6">June - 06</asp:ListItem>
                                        <asp:ListItem Value="7">July - 07</asp:ListItem>
                                        <asp:ListItem Value="8">August - 08</asp:ListItem>
                                        <asp:ListItem Value="9">September - 09</asp:ListItem>
                                        <asp:ListItem Value="10">October - 10</asp:ListItem>
                                        <asp:ListItem Value="11">November - 11</asp:ListItem>
                                        <asp:ListItem Value="12">December - 12</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="txtCCYear" runat="server" EnableViewState="False">
                                        <asp:ListItem Value="2017">2017</asp:ListItem>
                                        <asp:ListItem Value="2018">2018</asp:ListItem>
                                        <asp:ListItem Value="2019">2019</asp:ListItem>
                                        <asp:ListItem Value="2020">2020</asp:ListItem>
                                        <asp:ListItem Value="2021">2021</asp:ListItem>
                                        <asp:ListItem Value="2022">2022</asp:ListItem>
                                        <asp:ListItem Value="2023">2023</asp:ListItem>
                                        <asp:ListItem Value="2024">2024</asp:ListItem>
                                        <asp:ListItem Value="2025">2025</asp:ListItem>
                                        <asp:ListItem Value="2026">2026</asp:ListItem>
                                        <asp:ListItem Value="2027">2027</asp:ListItem>
                                        <asp:ListItem Value="2028">2028</asp:ListItem>
                                        <asp:ListItem Value="2029">2029</asp:ListItem>
                                        <asp:ListItem Value="2030">2030</asp:ListItem>
                                    </asp:DropDownList>
                                </li>
                                <li>
                                    <h4 class="card-title">Security Code:</h4>
									<asp:TextBox ID="txtSecurity" runat="server" CssClass="form-control mb-3" ></asp:TextBox>
                                </li>
                                <li>
                                    <asp:Label ID="lblCheckOutTotal" runat="server" CssClass="mt-4 h4"></asp:Label>
                                    <br />
                                    <asp:Button CssClass="btn btn-success mt-3" runat="server" Text="Submit Order" ID="btnCheckOut" OnClick="btnCheckOut_Click" />
                                    <br />
                                    <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger"></asp:Label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
