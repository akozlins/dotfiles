
using namespace RooFit;

class Util
{
public:
    /**
     * Configure RooFit.
     */
    static void configureRooFit()
    {
        std::cout << "Configure RooFit:" << std::endl;

        std::cout << "  Configure root style" << std::endl;
        gStyle->SetOptStat("");
//        gStyle->SetPadTopMargin(0.05);
//        gStyle->SetPadRightMargin(0.05);
//        gStyle->SetPadBottomMargin(0.10);
//        gStyle->SetPadLeftMargin(0.08);
        gStyle->SetPadTopMargin(0.06);
        gStyle->SetPadBottomMargin(0.12);
        gStyle->SetPadRightMargin(0.10);
        gStyle->SetPadLeftMargin(0.10);
        gStyle->SetTitleXOffset(1.05);
        gStyle->SetTitleYOffset(0.95);
        gStyle->SetTitleXSize(0.05);
        gStyle->SetTitleYSize(0.05);
        gStyle->SetTitleStyle(0);
        gStyle->SetLabelSize(0.05, "xy");
        TGaxis::SetMaxDigits(3);

        gStyle->SetTitleFont(132, "xyz");
        gStyle->SetLabelFont(132, "xyz");

        std::cout << "  Disable RooMsgService stream (1)" << std::endl;
        RooMsgService::instance().deleteStream(1);

        std::cout << "  Set integrator EpsRel and EpsAbs to 1e-8" << std::endl;
        RooAbsPdf::defaultIntegratorConfig()->setEpsRel(1e-8);
        RooAbsPdf::defaultIntegratorConfig()->setEpsAbs(1e-8);

        std::cout << "  Set 1D integrator to adaptive GaussKronrod" << std::endl;
        RooAbsReal::defaultIntegratorConfig()->method1D().setLabel("RooAdaptiveGaussKronrodIntegrator1D");
        RooAbsReal::defaultIntegratorConfig()->getConfigSection("RooAdaptiveGaussKronrodIntegrator1D").setRealValue("maxSeg", 50);
        RooAbsReal::defaultIntegratorConfig()->getConfigSection("RooAdaptiveGaussKronrodIntegrator1D").setCatLabel("method", "31Points");
        RooAbsReal::defaultIntegratorConfig()->getConfigSection("RooIntegrator1D").setRealValue("maxSteps", 50);

        std::cout << std::endl;
    }

    /**
     *
     */
    static TCanvas* createCanvas(char* name, int w = 640, int h = 480)
    {
        TCanvas* canvas = new TCanvas(name, name, 0, 0, w, h);
        canvas->SetWindowSize(w + (w - canvas->GetWw()), h + (h - canvas->GetWh()));
        return canvas;
    }

    /**
     *
     */
    static bool drawLatex(RooPlot* f, int n, char* str, RooRealVar* var, double k = 1.0)
    {
        if(var == 0 || var->isConstant() || var->getError() == 0) return false;
        return drawLatex(f, n, str, k * var->getVal(), k * var->getError());
    }

    /**
     *
     */
    static bool drawLatex(RooPlot* f, int n, char* str, double val, double err)
    {
        if(err == 0) return false;

        TLatex lat;
        lat.SetTextSize(0.045);

        double minx = f->GetXaxis()->GetXmin(), maxx = f->GetXaxis()->GetXmax();
        double miny = f->GetMinimum(), maxy = f->GetMaximum();

        char text[128];
        snprintf(text, sizeof(text), str, val, err);
        lat.DrawLatex(minx + 0.04 * (maxx - minx), miny + (0.93 - 0.08 * n) * (maxy - miny), text);

        return true;
    }

    /**
     *
     */
    static void adjustFrameYRange(RooPlot* f)
    {
        if(f->GetMaximum() > 10) f->SetMaximum((int)(f->GetMaximum() + pow(10, (int)log10(f->GetMaximum()) - 1)) - (int)f->GetMaximum() % (int)pow(10, (int)log10(f->GetMaximum()) - 1));
        f->SetMinimum(1e-6);
    }
};
