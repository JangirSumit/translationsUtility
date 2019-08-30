use Mits2
go


CREATE proc test.sp_GetTranslation
@lang nvarchar(10) = 'EN'

as 

BEGIN

DECLARE @STR NVARCHAR(1000) = ''

SET @STR = 'SELECT A.ID, A.METATAG, EN,' + @lang + ' FROM test.LFXTranslations A JOIN test.LFXMappings B ON A.ID = B.LFXTranslationId'

EXEC(@STR)


END

GO