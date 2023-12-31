USE [GPA_CAT42_SP_2021]
GO
/****** Object:  UserDefinedFunction [dbo].[F_CHAVE_DFe_GERAR_ChaveSemDV]    Script Date: 30/08/2023 18:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[F_CHAVE_DFe_GERAR_ChaveSemDV](@ChaveSemDV nvarchar(43)) RETURNS nvarchar(44)
BEGIN

DECLARE 
    @Dv Nvarchar(1)

--- PEGO O TAMANHO DO NÚMERO DE ENTRADA
DECLARE @TamanhoDoCodigoSemDV INTEGER
SET @TamanhoDoCodigoSemDV  = LEN(@ChaveSemDV)

-- CRIO UMA VARIÁVEL SOMATÓRIO 
DECLARE @Soma INTEGER
SET @Soma = 0

--CRIO UM MULTIPLICADOR
DECLARE @Multiplicador INTEGER
SET @Multiplicador = 2

--CRIO UMA VARIÁVEL PARA FAZER O CALULO ATÉ O TAMANHO DO NUMERO DE ENTRADA 
DECLARE @i integer
SET @i = 1

WHILE @i <= @TamanhoDoCodigoSemDV 
  BEGIN
    --PRINT convert(varchar(3),@Multiplicador) + ' - ' + convert(varchar(3), @i) + ' - ' + (LEFT(RIGHT(@ChaveSemDV, @i),1))
    SET @Soma = @Soma + (LEFT(RIGHT(@ChaveSemDV, @i),1) * @Multiplicador)
    SELECT @Multiplicador = 
        CASE -- Reinicia o Multiplicador em 2 quando maior que 9
            WHEN @Multiplicador < 9 
            THEN @Multiplicador + 1 
            ELSE 2 END 
    SET @i = @i + 1
  END

--PRINT 'Soma: ' + CONVERT(varchar, @Soma)

SELECT @Dv = CASE WHEN @Soma%11 IN (0, 1) THEN 0 ELSE 11 - (@Soma%11) END

RETURN @ChaveSemDV + @Dv

END