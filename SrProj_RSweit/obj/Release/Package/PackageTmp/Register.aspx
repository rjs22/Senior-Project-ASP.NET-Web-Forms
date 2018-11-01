<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SrProj_RSweit.Register" %>
<%@ MasterType VirtualPath="~/Master.Master" %>

<asp:Content ID="Content" ContentPlaceHolderID="main" runat="server">
    <%-- Bootstrap format and styling --%>
    <div class="container-fluid">
        <div class="row">
            <div class="mx-auto">
                <%-- Registration form --%>
                <ul class="list-unstyled">
                    <li>
                        <h2 class="display-2 text-light">Registration</h2>
                    </li>
                    <li>
                        <p>
                            <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-danger"></asp:Label>
                        </p>
                    </li>
                    <li>
                        <asp:Label runat="server" CssClass="form-control-label text-light">Email</asp:Label>

                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />

                        <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." ValidationGroup="register"/>
                        
                        <asp:RequiredFieldValidator ID="reqEmail" ErrorMessage="Please enter valid email" Display="Dynamic" ForeColor="Red"
                            ControlToValidate="txtEmail" runat="server"  ValidationGroup="register" />

                    </li>
                    <li>
                        <asp:Label runat="server" CssClass="form-control-label text-light">Password</asp:Label>

                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />

                        <asp:RegularExpressionValidator runat="server" Display = "Dynamic" ValidationExpression = "^[\s\S]{8,}$"
                            ControlToValidate = "txtPassword" ForeColor="Red" ErrorMessage="Minimum 8 characters required." ValidationGroup="register"/>

                        <asp:RequiredFieldValidator ID="reqPass" ErrorMessage="Please enter a password" ForeColor="Red" ControlToValidate="txtPassword"
                            runat="server"  ValidationGroup="register" />

                    </li>
                    <li>
                        <asp:Label runat="server" CssClass="form-control-label text-light">Confirm Password</asp:Label>

                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />

                        <asp:RequiredFieldValidator ID="reqConfPass" ErrorMessage="Please confirm your password" ForeColor="Red" ControlToValidate="txtConfirmPassword"
                            runat="server"  ValidationGroup="register" />

                        <asp:CompareValidator ID="cmpPass" ErrorMessage="Passwords do not match." ForeColor="Red" ControlToCompare="txtPassword"
                            ControlToValidate="txtConfirmPassword" runat="server" ValidationGroup="register" />
                        
                        <asp:Button ID="btnSubmit" ValidationGroup="register" CausesValidation="true" CssClass="mx-auto mt-5 btn btn-secondary " OnClick="BtnRegister_Click" Text="Submit" runat="server" />
                    </li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
