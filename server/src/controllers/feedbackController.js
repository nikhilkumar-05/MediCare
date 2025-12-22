import Feedback from '../models/Feedback.js';
import Doctor from '../models/Doctor.js';

export const createFeedback = async (req, res) => {
    try {
        const { doctorId, rating, comment } = req.body;

        // Ensure doctor exists
        const doctor = await Doctor.findById(doctorId);
        if (!doctor) {
            return res.status(404).json({ message: 'Doctor not found' });
        }

        const feedback = await Feedback.create({
            patientId: req.user._id,
            doctorId,
            rating,
            comment
        });

        res.status(201).json(feedback);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

export const getMyFeedback = async (req, res) => {
    try {
        if (req.user.role === 'patient') {

            const feedbacks = await Feedback.find({ patientId: req.user._id })
                .populate('doctorId', 'userId')  
                .sort({ createdAt: -1 });


            const populatedFeedbacks = await Feedback.find({ patientId: req.user._id })
                .populate({
                    path: 'doctorId',
                    populate: { path: 'userId', select: 'name' }
                })
                .sort({ createdAt: -1 });

            return res.json(populatedFeedbacks);
        } else {
            const doctor = await Doctor.findOne({ userId: req.user._id });
            if (!doctor) {
                return res.status(404).json({ message: 'Doctor profile not found' });
            }

            const feedbacks = await Feedback.find({ doctorId: doctor._id })
                .populate('patientId', 'name')
                .sort({ createdAt: -1 });

            res.json(feedbacks);
        }
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
