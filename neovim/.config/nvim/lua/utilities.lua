local M = {}

---@param opts table
M.make_modal = function(opts)
    if not opts then
        opts = {}
    end
    local width = vim.o.columns - 4
    local height = 19
    local winid = vim.fn.win_getid()

    if opts.max_width then
        if (vim.o.columns > 85) then
            width = 80
        end
    end

    vim.api.nvim_open_win(
        vim.api.nvim_create_buf(false, true),
        true,
        {
            relative = 'editor',
            style = 'minimal',
            border = 'shadow',
            width = width,
            height = height,
            col = math.min((vim.o.columns - width) * 0.5),
            row = math.min((vim.o.lines - height) * 0.5 - 1),
            noautocmd = true,
        }
    )
end

---@param files_command string
---@param action string
M.fuzzy_search = function(files_command, action)
    M.make_modal({max_width = true})

    local file = vim.fn.tempname()
    local shell_command = {
        '/bin/sh',
        '-c',
        files_command .. ' | fzy > ' .. file
    }

    vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })

    vim.fn.termopen(shell_command, {
        on_exit = function()
            vim.api.nvim_cmd(
                { cmd = 'bdelete', bang = true },
                { output = false }
            )
            vim.fn.win_gotoid(winid)
            local f = io.open(file, 'r')
            if f == nil then return end
            local stdout = f:read('*all')
            f:close()
            os.remove(file)
            vim.api.nvim_command(table.concat({ action, stdout }, ' '))
        end
    })
end

---@return string
M.autocomplete_html_attribute = function()
    -- The cursor location does not give us the correct node in this case, so
    -- we need to get the node to the left of the cursor.
    local cursor = vim.api.nvim_win_get_cursor(0)
    local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }
    local node = vim.treesitter.get_node { pos = left_of_cursor_range }
    local nodes_active_in = {
        'attribute_name',
        'directive_argument',
        'directive_name',
    }
    if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
        -- The cursor is not on an attribute node
        return '='
    end
    return '=""<left>'
end

---@param text_with_URLs string
M.find_url = function(text_with_URLs)
    local domains = [[.ac.ad.ae.aero.af.ag.ai.al.am.an.ao.aq.ar.arpa.as.asia.at
    .au.aw.ax.az.ba.bb.bd.be.bf.bg.bh.bi.biz.bj.bm.bn.bo.br.bs.bt.bv.bw.by.bz
    .ca.cat.cc.cd.cf.cg.ch.ci.ck.cl.cm.cn.co.com.coop.cr.cs.cu.cv.cx.cy.cz.dd
    .de.dj.dk.dm.do.dz.ec.edu.ee.eg.eh.er.es.et.eu.fi.firm.fj.fk.fm.fo.fr.fx
    .ga.gb.gd.ge.gf.gh.gi.gl.gm.gn.gov.gp.gq.gr.gs.gt.gu.gw.gy.hk.hm.hn.hr.ht
    .hu.id.ie.il.im.in.info.int.io.iq.ir.is.it.je.jm.jo.jobs.jp.ke.kg.kh.ki.km
    .kn.kp.kr.kw.ky.kz.la.lb.lc.li.lk.lr.ls.lt.lu.lv.ly.ma.mc.md.me.mg.mh.mil
    .mk.ml.mm.mn.mo.mobi.mp.mq.mr.ms.mt.mu.museum.mv.mw.mx.my.mz.na.name.nato
    .nc.ne.net.nf.ng.ni.nl.no.nom.np.nr.nt.nu.nz.om.org.pa.pe.pf.pg.ph.pk.pl.pm
    .pn.post.pr.pro.ps.pt.pw.py.qa.re.ro.ru.rw.sa.sb.sc.sd.se.sg.sh.si.sj.sk
    .sl.sm.sn.so.sr.ss.st.store.su.sv.sy.sz.tc.td.tel.tf.tg.th.tj.tk.tl.tm.tn
    .to.tp.tr.travel.tt.tv.tw.tz.ua.ug.uk.um.us.uy.va.vc.ve.vg.vi.vn.vu.web.wf
    .ws.xxx.ye.yt.yu.za.zm.zr.zw]]
    local tlds = {}
    for tld in domains:gmatch'%w+' do
        tlds[tld] = true
    end
    local function max4(a,b,c,d) return math.max(a+0, b+0, c+0, d+0) end
    local protocols = {[''] = 0, ['http://'] = 0, ['https://'] = 0, ['ftp://'] = 0}
    local finished = {}

    for pos_start, url, prot, subd, tld, colon, port, slash, path in
        text_with_URLs:gmatch'()(([%w_.~!*:@&+$/?%%#-]-)(%w[-.%w]*%.)(%w+)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*))'
        do
        if protocols[prot:lower()] == (1 - #slash) * #path and not subd:find'%W%W'
            and (colon == '' or port ~= '' and port + 0 < 65536)
            and (tlds[tld:lower()] or tld:find'^%d+$' and subd:find'^%d+%.%d+%.%d+%.$'
            and max4(tld, subd:match'^(%d+)%.(%d+)%.(%d+)%.$') < 256)
        then
            finished[pos_start] = true
            return url
        end
    end

    for pos_start, url, prot, dom, colon, port, slash, path in
        text_with_URLs:gmatch'()((%f[%w]%a+://)(%w[-.%w]*)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*))'
        do
        if not finished[pos_start] and not (dom..'.'):find'%W%W'
            and protocols[prot:lower()] == (1 - #slash) * #path
            and (colon == '' or port ~= '' and port + 0 < 65536)
        then
            return url
        end
    end
end

return M

-- vim:fdm=marker ft=lua et sts=4 sw=4
