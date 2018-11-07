import styled from "styled-components"

export const Header = styled.div`
    display: grid;
    grid-template-columns: 1fr 1fr;
`

export const HeaderLeft = styled.div`
    text-align: left;
`

export const HeaderRight = styled.div`
    text-align: right;
`

export const Nav = styled.div`
    display: grid;
    grid-template-columns: repeat(3, 1fr);
`
export const NavItem = styled.div`
    border: 1px solid black;
    text-align: center;
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