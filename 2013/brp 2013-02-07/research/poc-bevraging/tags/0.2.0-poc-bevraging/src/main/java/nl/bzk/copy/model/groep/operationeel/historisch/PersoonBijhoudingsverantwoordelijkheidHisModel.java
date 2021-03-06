/**
 * This file is copyright 2017 State of the Netherlands (Ministry of Interior Affairs and Kingdom Relations).
 * It is made available under the terms of the GNU Affero General Public License, version 3 as published by the Free Software Foundation.
 * The project of which this file is part, may be found at https://github.com/MinBZK/operatieBRP.
 */

package nl.bzk.copy.model.groep.operationeel.historisch;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.Table;

import nl.bzk.copy.model.groep.operationeel.AbstractPersoonBijhoudingsverantwoordelijkheidGroep;
import nl.bzk.copy.model.groep.operationeel.historisch.basis.AbstractPersoonBijhoudingsverantwoordelijkheidHisModel;
import nl.bzk.copy.model.objecttype.operationeel.PersoonModel;


/**
 * User implementatie van PersoonBijhoudingsverantwoordelijkheidHis.
 */
@Entity
@Table(schema = "kern", name = "his_persbijhverantwoordelijk")
@Access(AccessType.FIELD)
@SuppressWarnings("serial")
public class PersoonBijhoudingsverantwoordelijkheidHisModel
        extends AbstractPersoonBijhoudingsverantwoordelijkheidHisModel
{

    /**
     * Standaard constructor.
     *
     * @param persoonBijhoudingsverantwoordelijkheidGroep
     *                     de groep met daarin de bijhoudingsverantwoordelijke
     * @param persoonModel de persoon waartoe de groep behoord
     */
    public PersoonBijhoudingsverantwoordelijkheidHisModel(
            final AbstractPersoonBijhoudingsverantwoordelijkheidGroep persoonBijhoudingsverantwoordelijkheidGroep,
            final PersoonModel persoonModel)
    {
        super(persoonBijhoudingsverantwoordelijkheidGroep, persoonModel);
    }

    /**
     * Standaard (lege) constructor.
     */
    protected PersoonBijhoudingsverantwoordelijkheidHisModel() {
    }

    @Override
    public PersoonBijhoudingsverantwoordelijkheidHisModel kopieer() {
        return new PersoonBijhoudingsverantwoordelijkheidHisModel(this, getPersoon());
    }
}
