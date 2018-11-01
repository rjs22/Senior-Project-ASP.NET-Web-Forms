<%@ Page Title="Login" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SrProj_RSweit.Login" %>
<%@ MasterType VirtualPath="~/Master.Master" %>

<asp:Content ID="Content" ContentPlaceHolderID="main" runat="server">
    <%-- Bootstrap formatting and styling --%>
    <div class="container-fluid">
        <div class="row">
            <div class="mx-auto">
                <%-- ASPX login cotrol --%>
                <checkboxstyle cssclass="form-control-label text-light" horizontalalign="Center" />
                <labelstyle cssclass="form-control-label text-light" verticalalign="Middle" />
                <table cellspacing="0" cellpadding="1" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table cellpadding="0">
                                <tr>
                                    <td class=" display-2 text-light" align="center" colspan="2" style="border-width: 3px; border-style: solid; height: 75px;">Log In</td>
                                </tr>
                                <tr>
                                    <td class="form-control-label text-light" align="right" valign="middle">
                                        <asp:Label runat="server" AssociatedControlID="Email" ID="UserNameLabel">Email:</asp:Label></td>
                                    <td>
                                        <asp:TextBox runat="server" CssClass="form-control mt-3 ml-1 text-dark" ID="Email"></asp:TextBox>

                                        <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                            ControlToValidate="Email" ForeColor="Red" ErrorMessage="Invalid email address." ValidationGroup="login" />

                                        <asp:RequiredFieldValidator CssClass="text-danger" runat="server" ControlToValidate="Email" ErrorMessage="Email is required."
                                            ValidationGroup="login" ID="UserNameRequired">*Email is required</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-control-label text-light" align="right" valign="middle">
                                        <asp:Label runat="server" AssociatedControlID="Password" ID="PasswordLabel">Password:</asp:Label></td>
                                    <td>
                                        <asp:TextBox runat="server" TextMode="Password" CssClass="form-control mt-3 ml-1 text-dark" ID="Password"></asp:TextBox>
                                        
                                        <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="^[\s\S]{8,}$"
                                            ControlToValidate="Password" ForeColor="Red" ErrorMessage="Minimum 8 characters required." ValidationGroup="login" />
                                        
                                        <asp:RequiredFieldValidator CssClass="text-danger" runat="server" ControlToValidate="Password" ErrorMessage="Password is required."
                                            ValidationGroup="login" ID="PasswordRequired">*Password is required</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-control-label text-light" align="center" colspan="2">
                                        <asp:CheckBox runat="server" Text="Remember me next time." ID="RememberMe"></asp:CheckBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button runat="server" Text="Log In" ValidationGroup="login" CausesValidation="true"
                                            CssClass="btn btn-secondary mr-3 mt-2" Width="250px" ID="LoginButton" OnClick="LoginButton_Click"></asp:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: Red;"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <titletextstyle cssclass=" display-2 text-light" borderwidth="3px" height="75px" />
                <textboxstyle cssclass="form-control mt-3 ml-1 text-light" />
                <loginbuttonstyle cssclass=" btn btn-secondary mr-3 mt-2" width="250px" />
                <a href="Register.aspx" class="text-secondary" style="margin-left: 50px;">Not a member? Register now!</a>
            </div>
        </div>
    </div>
</asp:Content>