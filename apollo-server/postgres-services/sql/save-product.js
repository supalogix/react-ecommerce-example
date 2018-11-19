export default (product) =>  `
    INSERT INTO dbo.lpr_product
    (
        pr_idy_product_identity,
        pr_nam_product_name,
        pr_nam_changedat,
        pr_dsc_product_description,
        pr_dsc_changedat
    )
    VALUES
    (
        '${product.id}',
        '${product.name}',
        '${product.creationDate}',
        '${product.description}'
        '${product.creationDate}'
    )
`