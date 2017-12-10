#if !defined( __CINT__) || defined (__MAKECINT__)

#ifndef ROOT_TStyle
#include "TStyle.h"
#endif

#endif

void rootlogon()
{
    TStyle *tmpStyle = gROOT->GetStyle("Default");

    tmpStyle->SetFuncWidth(2);

    tmpStyle->SetAxisColor(1, "xyx");
    tmpStyle->SetNdivisions(510, "xyz");
    tmpStyle->SetTickLength(0.025, "xyz");

    tmpStyle->SetLabelColor(1, "xyx");
    tmpStyle->SetLabelFont(132, "xyz");
    tmpStyle->SetLabelOffset(0.005, "xyz");
    tmpStyle->SetLabelSize(0.05, "xyz");

    tmpStyle->SetTitleColor(1, "xyz");
    tmpStyle->SetTitleFont(132, "xyz");
    tmpStyle->SetTitleOffset(1, "xyz");
    tmpStyle->SetTitleSize(0.05, "xyz");

    tmpStyle->SetDrawBorder(0);
    tmpStyle->SetOptLogx(0);
    tmpStyle->SetOptLogy(0);
    tmpStyle->SetOptLogz(0);
    tmpStyle->SetOptDate(0);
    tmpStyle->SetOptStat(1111);
    tmpStyle->SetOptTitle(kFALSE);
    tmpStyle->SetOptFit(111);
    tmpStyle->SetNumberContours(99);
    tmpStyle->SetEndErrorSize(2);
    tmpStyle->SetFuncColor(1);
    tmpStyle->SetFuncStyle(1);
    tmpStyle->SetFuncWidth(1);
    tmpStyle->SetGridColor(0);
    tmpStyle->SetGridStyle(3);
    tmpStyle->SetGridWidth(1);
    tmpStyle->SetLegendBorderSize(1);
    tmpStyle->SetFrameFillColor(0);
    tmpStyle->SetFrameLineColor(1);
    tmpStyle->SetFrameFillStyle(1001);
    tmpStyle->SetFrameLineStyle(1);
    tmpStyle->SetFrameLineWidth(1);
    tmpStyle->SetFrameBorderSize(1);
    tmpStyle->SetFrameBorderMode(0);
    tmpStyle->SetHistFillColor(0);
    tmpStyle->SetHistLineColor(1);
    tmpStyle->SetHistFillStyle(1001);
    tmpStyle->SetHistLineStyle(1);
    tmpStyle->SetHistLineWidth(1);
    tmpStyle->SetHistMinimumZero(kFALSE);
    tmpStyle->SetCanvasPreferGL(kFALSE);
    tmpStyle->SetCanvasColor(0);
    tmpStyle->SetCanvasBorderSize(1);
    tmpStyle->SetCanvasBorderMode(0);
    tmpStyle->SetCanvasDefW(640);
    tmpStyle->SetCanvasDefH(480);
    tmpStyle->SetCanvasDefX(10);
    tmpStyle->SetCanvasDefY(10);
    tmpStyle->SetPadColor(0);
    tmpStyle->SetPadBorderSize(1);
    tmpStyle->SetPadBorderMode(0);
    tmpStyle->SetPadBottomMargin(0.1);
    tmpStyle->SetPadTopMargin(0.1);
    tmpStyle->SetPadLeftMargin(0.1);
    tmpStyle->SetPadRightMargin(0.1);
    tmpStyle->SetPadGridX(kFALSE);
    tmpStyle->SetPadGridY(kFALSE);
    tmpStyle->SetPadTickX(0);
    tmpStyle->SetPadTickY(0);
    tmpStyle->SetStatColor(0);
    tmpStyle->SetStatTextColor(1);
    tmpStyle->SetStatBorderSize(1);
    tmpStyle->SetStatFont(132);
    tmpStyle->SetStatFontSize(0);
    tmpStyle->SetStatStyle(1001);
    tmpStyle->SetStatFormat("6.4g");
    tmpStyle->SetStatX(0.99);
    tmpStyle->SetStatY(0.99);
    tmpStyle->SetStatW(0.2);
    tmpStyle->SetStatH(0.2);
    tmpStyle->SetStripDecimals(kTRUE);
    tmpStyle->SetTitleAlign(13);
    tmpStyle->SetTitleFillColor(0);
    tmpStyle->SetTitleTextColor(1);
    tmpStyle->SetTitleBorderSize(1);
    tmpStyle->SetTitleFont(132);
    tmpStyle->SetTitleFontSize(0.05);
    tmpStyle->SetTitleStyle(1001);
    tmpStyle->SetTitleX(0.01);
    tmpStyle->SetTitleY(0.995);
    tmpStyle->SetTitleW(0);
    tmpStyle->SetTitleH(0);

    tmpStyle->SetHeaderPS("");
    tmpStyle->SetTitlePS("");
    tmpStyle->SetFitFormat("6.4g");
    tmpStyle->SetPaintTextFormat("g");
    tmpStyle->SetLineScalePS(3);
    tmpStyle->SetColorModelPS(0);

    tmpStyle->SetLineColor(1);
    tmpStyle->SetLineStyle(1);
    tmpStyle->SetLineWidth(1);
    tmpStyle->SetFillColor(0);
    tmpStyle->SetFillStyle(1001);
    tmpStyle->SetMarkerColor(1);
    tmpStyle->SetMarkerSize(1);
    tmpStyle->SetMarkerStyle(1);
    tmpStyle->SetTextAlign(11);
    tmpStyle->SetTextAngle(0);
    tmpStyle->SetTextColor(1);
    tmpStyle->SetTextFont(132);
    tmpStyle->SetTextSize(0.05);
}

#include "util.cpp"
