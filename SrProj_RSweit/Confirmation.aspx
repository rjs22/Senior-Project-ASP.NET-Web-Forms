<%@ Page Title="Confirmation" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="SrProj_RSweit.Confirmation" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <div class="container-fluid">
        <h2 class="display-2 text-light text-center">Thank You for your Order!</h2>
        <div class="row justify-content-center">
            <div class="card" style="padding: 0%; margin-bottom: 10px;">
                <div class="card-body">
                    <p>
                        Thank you for your generous order of
                        <%= this.OrderAmount %>.
                    </p>
                    We all had a wonderful celebration afterwards and the whole party 
             marched down the street to the post office where the entire town of Paia 
             waved 'Bon Voyage!' to your package, on its way to you.
            <p>
                Please come back and visit us again.
            </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
