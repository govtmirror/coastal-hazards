package gov.usgs.cida.coastalhazards.sld;

import gov.usgs.cida.coastalhazards.model.Item;
import javax.ws.rs.core.Response;
import org.apache.commons.lang.ArrayUtils;

/**
 *
 * @author Jordan Walker <jiwalker@usgs.gov>
 */
public abstract class SLDGenerator {
    
    protected Item item;
    protected final String commonSldName = "cch";
    
    public static SLDGenerator getGenerator(Item item) {
        SLDGenerator generator = null;
        switch(item.getType()) {
            case storms:
                Pcoi pcoi = new Pcoi(item);
                Extreme extreme = new Extreme(item);
                if (pcoi.isValidAttr(item.getAttr())) {
                    generator = pcoi;
                } else if (extreme.isValidAttr(item.getAttr())) {
                    generator = extreme;
                } else {
                    // more to come
                }
                break;
            case vulnerability:
                //something
                break;
            case historical:
                Shorelines shorelines = new Shorelines(item);
                if (shorelines.isValidAttr(item.getAttr())) {
                    generator = shorelines;
                } else {
                    // do something for rates
                }
                break;
            default:
                throw new IllegalArgumentException("Type not found");
        }
        return generator;
    }
    
    public SLDGenerator(Item item) {
        this.item = item;
    }
    
    public abstract Response generateSLD();
    public abstract Response generateSLDInfo();
    public abstract String[] getAttrs();
    
    public boolean isValidAttr(String attr) {
        return ArrayUtils.contains(getAttrs(), attr.toUpperCase());
    }
    
    public String getCommonSldName() {
        return commonSldName;
    }
    
}
