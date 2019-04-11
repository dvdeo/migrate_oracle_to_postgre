CREATE OR REPLACE FUNCTION "API20NINSYO".f_chg_column (
  i_column  in  varchar2,                 -- カラム名値
  i_kbn     in  char    default  0        -- 区分(0:列名→属性名称,1:属性名称→列名)
) return varchar2
is

  cursor cur_col2name(i_column in varchar2) is
    select
      name
    from
      sp_mst_def
    where
      lower(col_name) = lower(i_column);

  cursor cur_name2col(i_column in varchar2) is
    select
      col_name
    from
      sp_mst_def
    where
      lower(name) = lower(i_column);

  w_column	varchar2(30000);

begin

  if i_column is not null then
    w_column := null;
    if i_kbn = 0 then
      open cur_col2name(i_column);
      fetch cur_col2name into w_column;
      if cur_col2name%NOTFOUND then
        w_column := null;
      end if;
      close cur_col2name;
    else
      open cur_name2col(i_column);
      fetch cur_name2col into w_column;
      if cur_name2col%NOTFOUND then
        w_column := null;
      end if;
      close cur_name2col;
    end if;
  end if;

  return w_column;
exception
  when others then
    return null;
end;