import styled from "styled-components"

export const Header = styled.div`
    display: grid;
    grid-template-columns: 1fr 1fr;
`

export const HeaderLeft = styled.div`
    font-size: 2em;
    text-align: left;
`

export const HeaderRight = styled.div`
    font-size: 1.25em
    text-align: right;
`

export const HeaderButton = styled.div`
    display: inline-block;
    margin-left: 1em;
`

export const Nav = styled.div`
    background-color: #333;
    overflow: hidden;
`
export const NavItem = styled.div`
    float: left;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    font-size: 17px;
`
export const Product = styled.div`
    border: 1px solid black;
    padding: 15px;
    width: 250px;
    margin: 15px;
`
export const ProductName = styled.div`
    font-size: 1.75em;
    margin: 0 0 .25em 0;
`

export const ProductPrice = styled.div`
    margin: 1em 0;
`

export const ProductDescription = styled.div`
    margin: 1em 0;
`

export const ProductEditLink = styled.span`
    font-size: .66em
`

export const ProductImage = styled.div`
`

export const ProductContainer = styled.div`
    display: flex;
    flex-wrap: wrap;
`

export const EditForm = styled.div`
    margin: 0 auto;
    width: 400px;
`

export const EditField = styled.div`
    margin: 1em 0;
`

export const EditLabel = styled.div`
`

export const EditInput = styled.div`
`

export const EditButton = styled.div`
    border: 1px solid black;
    background-color: #66bb00;
    width: 200px;
    padding: 10px;
    text-align: center;
`