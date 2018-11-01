<%@ Page Title="Customer Information" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="SrProj_RSweit.Customer" %>

<asp:Content ID="Content" ContentPlaceHolderID="main" runat="server">
    <%-- Bootstrap format and organization --%>
    <div class="container-fluid">
        <h2 class="display-2 text-light text-center">Customer Information Page</h2>
        <div class="row justify-content-center">
            <div class="col-sm-4">
                <div class="card" style="padding: 0%; margin-bottom: 10px;">
                    <h4 class="card-header text-light cardhead">Your Personal Information:</h4>
                    <div class="card-body">
                        <%-- Card that holds fields for current user --%>
                        <ul class="list-unstyled">
                            <li></li>
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

                            <li>
                                <asp:Button ID="btnSubmit" CssClass=" mt-3 btn btn-dark float-right" Text="Submit" OnClick="BtnSubmit_Click" runat="server" ValidationGroup="customer" CausesValidation="true" />
                                <asp:Button CssClass=" mt-3 btn btn-danger" Text="Clear Info" OnClick="BtnClear_Click" runat="server" />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <%-- Bootstrap format and organization --%>
            <div class="col-sm-7">
                <div class="card">
                    <h4 class="card-header text-light cardhead">Your Cart:</h4>
                    <div class="card-body">
                        <%-- Gridview for current user's cart --%>
                        <asp:GridView CssClass="mb-4" ShowHeader="false" DataKeyNames="CartID" ID="gvCart" runat="server" AutoGenerateColumns="false" 
                            GridLines="Horizontal" OnRowDeleting="gvCart_RowDeleting" OnRowUpdating="gvCart_RowUpdating" >
                            <Columns>

                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button CssClass="btn btn-danger" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" Text="Remove"></asp:Button>
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
                                        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" min="1" max="25" step="1" Text='<%# Eval("CartQuantity") %>'></asp:TextBox>
                                        <asp:Button CssClass="btn btn-dark float-right mt-3" runat="server" Text="Update" ID="btnUpdate" CommandName="update" CommandArgument='<%# Eval("CartQuantity") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label CssClass="h4 mt-4" ID="lblSub" runat="server" ></asp:Label>
                        <br />
                        <%-- error label --%>
                        <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger"></asp:Label>
                        <asp:Button CssClass="btn btn-success float-right mt-3" runat="server" Text="Check Out" ID="btnCheckOut" OnClick="btnCheckOut_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
