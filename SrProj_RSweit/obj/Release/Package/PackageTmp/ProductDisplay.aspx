<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ProductDisplay.aspx.cs" Inherits="SrProj_RSweit.ProductDisplay" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <%-- Bootstrap formatting and styling --%>
    <div class="container-fluid">
        <h2 class="display-2 text-light text-center">Product Information</h2>
        <div class="row justify-content-center">
            <%-- Product Information --%>
            <div class="container">
                <div class="card-group">
                    <%-- Left half of card holding image and product name --%>
                    <div class="card" style="padding: 0%; margin-bottom: 10px;">
                        <h4 id="hdProdName" runat="server" class="card-header text-light cardhead"></h4>
                        <div class="card-body">
                            <asp:Image runat="server" ID="imgProduct" CssClass="card-img-top cardimg" />
                        </div>
                    </div>
                    <%-- Right half of card holding descrpition, quantity, sizes, and add product to cart button --%>
                    <div class="card" style="padding: 0%; margin-bottom: 10px;">
                        <h4 id="h1" runat="server" class="card-header text-light cardhead">Product Description:</h4>
                        <div class="card-body d-flex align-items-start flex-column">
                            <div class="card-body d-flex align-items-start flex-column">
                                <asp:Label CssClass="mb-auto" runat="server" ID="lblDesc"></asp:Label>
                            </div>
                            <%-- Bootstrap format and styling for card functions --%>
                            <div class="card-body d-flex align-items-end flex-row">
                                <div class="card-body d-flex align-items-start flex-column p-0">
                                    <asp:Label runat="server" ID="lblQty" Visible="false">Quantity</asp:Label>
                                    <asp:TextBox CssClass="justify-content-end p-2" ID="txtQuantity" runat="server" 
                                        TextMode="Number" min="1" max="28" step="1" Text="1" Visible="false" />
                                </div>
                                <%-- Validator for quantity textbox to ensure it can only be between 1 and 28 --%>
                                <asp:RangeValidator runat="server" Type="Integer"
                                    MinimumValue="1" MaximumValue="28" ControlToValidate="txtQuantity" Visible="false"
                                    ErrorMessage="Value must be a whole number between 1 and 28" ValidationGroup="quantitycheck" />
                                <%-- drop down for size selection  --%>
                                <asp:DropDownList CssClass=" m-2 p-2" ID="ddlSize" runat="server" Visible="false">
                                    <asp:ListItem Value="1">Select Size</asp:ListItem>
                                    <asp:ListItem Value="2">Small</asp:ListItem>
                                    <asp:ListItem Value="3">Medium</asp:ListItem>
                                    <asp:ListItem Value="4">Large</asp:ListItem>
                                    <asp:ListItem Value="5">XL</asp:ListItem>
                                    <asp:ListItem Value="6">XXL + 2$</asp:ListItem>
                                    <asp:ListItem Value="7">XXXL + 2$</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Button CssClass="ml-auto btn btn-success" runat="server" ID="btnCart" CausesValidation="true"
                                    ValidationGroup="quantitycheck" Visible="false" OnClick="BtnCart_Click" Text="Add to Cart" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
