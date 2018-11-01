<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SrProj_RSweit.Default" %>

<asp:Content ID="Content" ContentPlaceHolderID="main" runat="server">
     <%-- Intro jumbotron with link button and styling --%>
        <div class="jumbotron jumbotron-fluid" style="background-image: linear-gradient(rgba(0,0,0,0.7),rgba(0,0,0,0.3)),url(Media/image000000_2.jpg); background-size: 100%; background-repeat: no-repeat; padding-top: 50%;">
            <div class="container" style="margin-top: -40%;">
                <h1 class="text-secondary display-1">Welcome</h1>
                <p class="text-secondary lead">To Reverand Jack's hot sauce</p>
                <a class="btn btn-secondary btn-lg mb-3" href="Products.aspx" role="button" >Explore our Products</a>
                <p class="text-light">-or-</p>
                <a class="btn btn-secondary btn-lg" href="Register.aspx" role="button" >Register to Start an Order</a>
            </div>
        </div>

        <%-- Cards holding products --%>
        <div class="container">
            <h2 class="display-2 text-light text-center" style="border-style:solid;">New and Featured Items</h2>
            <div class="row align-items-center">
                <%-- Hot from barrel Card --%>
                <div class="col-sm-5 mr-5 card" style="padding: 0%; margin-bottom: 10px">
                    <img class="card-img-top cardimg" src="Media/ProdImg/Habanero.png" alt="Card image cap" />
                    <h4 class="card-header text-light cardhead">Hot out of the Barrel!</h4>
                    <div class="card-body">
                        <h4 class="card-title">Reverand's Habanero:</h4>
                        <p class="card-text">Looking for that right flavor that's between the heat? Take a look at our tasty habanero recepie.</p>
                        <a href="Products.aspx" class="btn btn-dark">Check it out!</a>
                    </div>
                </div>
                <%-- Featured card --%>
                <div class="col-sm-5 al ml-5 card" style="padding: 0%; margin-bottom: 10px">
                    <img class="card-img-top" src="Media/ProdImg/ShirtXBoneBack.jpg" alt="Card image cap" />
                    <h4 class="card-header text-light cardhead">Featured</h4>
                    <div class="card-body">
                        <h4 class="card-title">New T-shirts Available</h4>
                        <p class="card-text">Help support your favorite hot sauce by letting everyone one know</p>
                        <a href="Products.aspx" class="btn btn-dark">Check it out!</a>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
