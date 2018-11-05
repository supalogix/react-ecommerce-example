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