#include "power_system_presenter.h"

// Qt
#include <QDebug>

using namespace presentation;

PowerSystemPresenter::PowerSystemPresenter(domain::Telemetry* node, QObject* parent):
    AbstractTelemetryPresenter(node, parent)
{}

void PowerSystemPresenter::onParametersChanged(const domain::Telemetry::TelemetryMap& parameters)
{
    if (parameters.contains(domain::Telemetry::Throttle))
        this->setViewsProperty(PROPERTY(throttle), parameters[domain::Telemetry::Throttle]);
}
