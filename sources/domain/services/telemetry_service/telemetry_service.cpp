#include "telemetry_service.h"

// Qt
#include <QMap>
#include <QDebug>

// Internal
#include "settings_provider.h"

#include "vehicle_service.h"
#include "vehicle.h"

#include "telemetry.h"
#include "telemetry_portion.h"
#include "vehicle_telemetry_factory.h"

#include "modes.h"

using namespace domain;

class TelemetryService::Impl
{
public:
    domain::VehicleService* service;

    QMap<int, Telemetry*> vehicleNodes;
    Telemetry radioNode;

    Impl():
        radioNode(Telemetry::Root)
    {}
};

TelemetryService::TelemetryService(VehicleService* service, QObject* parent):
    QObject(parent),
    d(new Impl())
{
    qRegisterMetaType<Telemetry::TelemetryList>("Telemetry::TelemetryList");
    qRegisterMetaType<Telemetry::TelemetryMap>("Telemetry::TelemetryMap");

    d->service = service;
    connect(d->service, &VehicleService::vehicleRemoved, this, &TelemetryService::onVehicleRemoved);
}

TelemetryService::~TelemetryService()
{}

QList<Telemetry*> TelemetryService::rootNodes() const
{
    QList<Telemetry*> list;

    list.append(d->vehicleNodes.values());
    list.append(&d->radioNode);

    return list;
}

Telemetry* TelemetryService::vehicleNode(int vehicleId) const
{
    if (!d->vehicleNodes.contains(vehicleId))
    {
        VehicleTelemetryFactory factory;
        d->vehicleNodes[vehicleId] = factory.create();
    }
    return d->vehicleNodes.value(vehicleId, nullptr);
}

Telemetry* TelemetryService::mavNode(int mavId) const
{
    return this->vehicleNode(d->service->vehicleIdByMavId(mavId));
}

Telemetry* TelemetryService::radioNode() const
{
    return &d->radioNode;
}

void TelemetryService::onVehicleRemoved(const dao::VehiclePtr& vehicle)
{
    delete d->vehicleNodes.take(vehicle->id());
}


