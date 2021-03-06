// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package nl.bzk.brp.model.web;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import nl.bzk.brp.model.data.kern.Actie;
import nl.bzk.brp.model.data.kern.HisRelatie;
import nl.bzk.brp.model.data.kern.Land;
import nl.bzk.brp.model.data.kern.Partij;
import nl.bzk.brp.model.data.kern.Plaats;
import nl.bzk.brp.model.data.kern.Rdnbeeindrelatie;
import nl.bzk.brp.model.data.kern.Relatie;
import nl.bzk.brp.model.web.HisRelatieController;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect HisRelatieController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String HisRelatieController.create(@Valid HisRelatie hisRelatie, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, hisRelatie);
            return "hisrelaties/create";
        }
        uiModel.asMap().clear();
        hisRelatie.persist();
        return "redirect:/hisrelaties/" + encodeUrlPathSegment(hisRelatie.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String HisRelatieController.createForm(Model uiModel) {
        populateEditForm(uiModel, new HisRelatie());
        return "hisrelaties/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String HisRelatieController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("hisrelatie", HisRelatie.findHisRelatie(id));
        uiModel.addAttribute("itemId", id);
        return "hisrelaties/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String HisRelatieController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("hisrelaties", HisRelatie.findHisRelatieEntries(firstResult, sizeNo));
            float nrOfPages = (float) HisRelatie.countHisRelaties() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("hisrelaties", HisRelatie.findAllHisRelaties());
        }
        addDateTimeFormatPatterns(uiModel);
        return "hisrelaties/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String HisRelatieController.update(@Valid HisRelatie hisRelatie, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, hisRelatie);
            return "hisrelaties/update";
        }
        uiModel.asMap().clear();
        hisRelatie.merge();
        return "redirect:/hisrelaties/" + encodeUrlPathSegment(hisRelatie.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String HisRelatieController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, HisRelatie.findHisRelatie(id));
        return "hisrelaties/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String HisRelatieController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        HisRelatie hisRelatie = HisRelatie.findHisRelatie(id);
        hisRelatie.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/hisrelaties";
    }
    
    void HisRelatieController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("hisRelatie_tsreg_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
        uiModel.addAttribute("hisRelatie_tsverval_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void HisRelatieController.populateEditForm(Model uiModel, HisRelatie hisRelatie) {
        uiModel.addAttribute("hisRelatie", hisRelatie);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("acties", Actie.findAllActies());
        uiModel.addAttribute("lands", Land.findAllLands());
        uiModel.addAttribute("partijs", Partij.findAllPartijs());
        uiModel.addAttribute("plaatses", Plaats.findAllPlaatses());
        uiModel.addAttribute("rdnbeeindrelaties", Rdnbeeindrelatie.findAllRdnbeeindrelaties());
        uiModel.addAttribute("relaties", Relatie.findAllRelaties());
    }
    
    String HisRelatieController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
