<%@ Page Title="Products" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="SrProj_RSweit.Products" %>

<asp:Content ID="Content" ContentPlaceHolderID="main" runat="server">
     <%-- Product Cards --%>

        <%-- Title --%>
        <h2 class="display-2 text-light text-center" style="border-style:solid;">Our Products</h2>

        <%-- List view holding all items --%>
        <asp:ListView ID="listview1" runat="server" DataKeyNames="ProductID" OnItemCommand="listview1_ItemCommand">
            
            <%-- Layout Template sets layout for all items used --%>
            <LayoutTemplate>
                <div class="container">
                    <div runat="server" id="cardProducts" class="row align-items-center">
                        <div runat="server" id="groupPlaceholder"></div>
                    </div>
                </div>

                <%-- Datapager (not working yet) --%>
                <asp:DataPager runat="server" ID="DataPager" PageSize="9">
                    <Fields>
                        <asp:NumericPagerField ButtonCount="3" PreviousPageText="<--" NextPageText="-->" />
                    </Fields>
                </asp:DataPager>
            </LayoutTemplate>

            <%-- Group Template To contain all item attributes to one group --%>
            <GroupTemplate>
                <div class="col-md-3 mr-5 ml-5 card text-center" style="padding: 0%; margin-bottom: 10px">
                    <div runat="server" id="itemPlaceholder"></div>
                </div>
            </GroupTemplate>

            <%-- Item Template to hold all attributes and properties for all items --%>
            <ItemTemplate>
                <div runat="server" class="card-body " style="padding: 0%;">
                    <asp:Image ID="ProductImage" runat="server" ImageUrl='<%# Eval("ProductImage") %>' CssClass="card-img-top cardimg" />
                    <h4 class="card-header text-light cardhead"><%# Eval("ProductName")%></h4>
                    <img class="card-img-top" src=" <%# Eval("ProductHeat")%> " style="height: 80px; width: 178px;" alt="Card image cap" />
                    <p class="card-text"><%# Eval("ProductShortDesc")%></p>
                    <asp:Button ID="btnSelect" runat="server" CommandArgument='<%# Eval("ProductID") %>' Text="View Product" />
                </div>
            </ItemTemplate>

            <%-- Default for no database return --%>
            <EmptyDataTemplate>
                <h2 class="display-2 text-light text-center">No Records!</h2>
            </EmptyDataTemplate>
        </asp:ListView>
    <asp:Label ID="TestLabel" runat="server" />
</asp:Content>
