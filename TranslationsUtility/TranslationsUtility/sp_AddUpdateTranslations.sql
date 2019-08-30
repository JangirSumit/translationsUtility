--mits2.db.sys.dom,4161


Use Mits2
GO

create proc test.sp_AddUpdateTranslations 
@metatag		varchar(510),
@description	text  = NULL,
@ar				ntext = NULL,
@bg				ntext = NULL,
@da				ntext = NULL,
@de				ntext = NULL,
@en				ntext = NULL,
@es				ntext = NULL,
@fr				ntext = NULL,
@el				ntext = NULL,
@he				ntext = NULL,
@it				ntext = NULL,
@ja				ntext = NULL,
@no				ntext = NULL,
@pl				ntext = NULL,
@pt				ntext = NULL,
@ru				ntext = NULL,
@sk				ntext = NULL,
@sl				ntext = NULL,
@sv				ntext = NULL,
@th				ntext = NULL,
@tr				ntext = NULL,
@hu				ntext = NULL,
@nl				ntext = NULL,
@ro				ntext = NULL,
@cs				ntext = NULL,
@hr				ntext = NULL,
@ko				ntext = NULL,
@fi				ntext = NULL,
@br				ntext = NULL,
@ptBR			ntext = NULL,
@zhCN			ntext = NULL,
@zhTW			ntext = NULL

as

BEGIN

IF NOT EXISTS (SELECT TOP 1 1 FROM test.LFXTranslations WHERE metatag LIKE @metatag)
BEGIN 

INSERT INTO test.LFXTranslations (metatag) values(@metatag)

INSERT INTO test.LFXMappings (ApplicationId,LFXTranslationId)
SELECT TOP 1 1, id
FROM test.LFXTranslations
WHERE metatag like @metatag

END

UPDATE test.LFXTranslations
SET 
description = @description,
ar = coalesce(@ar , ar),
bg = coalesce(@br , br),
da = coalesce(@da , da),
de = coalesce(@de , de),
en = coalesce(@en , en),
es = coalesce(@es , es),
fr = coalesce(@fr , fr),
el = coalesce(@el , el),
he = coalesce(@he , he),
it = coalesce(@it , it),
ja = coalesce(@ja , ja),
no = coalesce(@no , no),
pl = coalesce(@pl , pl),
pt = coalesce(@pt , pt),
ru = coalesce(@ru , ru),
sk = coalesce(@sk , sk),
sl = coalesce(@sl , sl),
sv = coalesce(@sv , sv),
th = coalesce(@th , th),
tr = coalesce(@tr , tr),
hu = coalesce(@hu , hu),
nl = coalesce(@nl , nl),
ro = coalesce(@ro , ro),
cs = coalesce(@cs , cs),
hr = coalesce(@hr , hr),
ko = coalesce(@ko , ko),
fi = coalesce(@fi , fi),
br = coalesce(@br , br),
[pt-BR] = coalesce(@ptBR , [pt-BR]),
[zh-cn] = coalesce(@zhCN , [zh-cn]),
[zh-tw] = coalesce(@zhTW , [zh-tw])
WHERE metatag like @metatag 

END

GO

